import 'package:auror/layers/domain/models/revision_domain.dart';
import 'package:auror/layers/domain/usecases/get_card_revision.dart';
import 'package:auror/layers/domain/usecases/send_answer.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_event.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_state.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RevisionQuizViewModel extends Bloc<RevisionQuizEvent, RevisionQuizState> {
  /// Deep-mode answer field; cleared when advancing to the next card or [RevisionQuizClearAnswerDraft].
  final TextEditingController answerDraftController;

  /// When set, revision may be loaded with [IGetCardRevision] if [RevisionQuizState.allRevisions] was empty.
  final String? cardId;

  final ISendAnswer _sendAnswer;
  final IGetCardRevision _getCardRevision;

  RevisionQuizViewModel(
    this._sendAnswer,
    this._getCardRevision, {
    @factoryParam required List<RevisionDomain> revisions,
    @factoryParam this.cardId,
  }) : answerDraftController = TextEditingController(),
       super(
         RevisionQuizState(
           allRevisions: revisions,
           currentRevision: revisions.isEmpty
               ? null
               : RevisionQuizUI.fromDomain(revisions.first),
           isLoading: cardId != null && revisions.isEmpty,
         ),
       ) {
    on<RevisionQuizStarted>(_onStarted);
    on<RevisionQuizAnswerDraftChanged>(_onAnswerDraftChanged);
    on<RevisionQuizClearAnswerDraft>(_onClearAnswerDraft);
    on<RevisionQuizDeepModeToggled>(_onDeepModeToggled);
    on<RevisionQuizRevealAnswer>(_onRevealAnswer);
    on<RevisionQuizAdvanceAfterFeedback>(_onAdvanceAfterFeedback);
    on<RevisionQuizShouldPopConsumed>(_onShouldPopConsumed);
    on<RevisionQuizAnswerSent>(_onAnswerSent);
  }

  void _onAnswerDraftChanged(
    RevisionQuizAnswerDraftChanged event,
    Emitter<RevisionQuizState> emit,
  ) {
    emit(state.copyWith(isSendAnswerCTAEnabled: event.text.trim().isNotEmpty));
  }

  Future<void> _onStarted(
    RevisionQuizStarted event,
    Emitter<RevisionQuizState> emit,
  ) async {
    final id = cardId;
    if (id == null) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    try {
      final revision = await _getCardRevision(cardId: id);
      emit(
        state.copyWith(
          allRevisions: [revision],
          currentRevision: RevisionQuizUI.fromDomain(revision),
          isLoading: false,
        ),
      );
    } on Object {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearAnswerDraft(
    RevisionQuizClearAnswerDraft event,
    Emitter<RevisionQuizState> emit,
  ) {
    answerDraftController.clear();
    emit(state.copyWith(isSendAnswerCTAEnabled: false));
  }

  void _onDeepModeToggled(
    RevisionQuizDeepModeToggled event,
    Emitter<RevisionQuizState> emit,
  ) {
    final nextDeep = !state.deepMode;
    emit(
      state.copyWith(
        deepMode: nextDeep,
        isSendAnswerCTAEnabled: nextDeep
            ? answerDraftController.text.trim().isNotEmpty
            : false,
        revealAnswerCTAEnabled: !nextDeep,
      ),
    );
  }

  void _onRevealAnswer(
    RevisionQuizRevealAnswer event,
    Emitter<RevisionQuizState> emit,
  ) {
    emit(
      state.copyWith(
        answerRevealed: true,
        shouldShowAnswerSentDisclaimer: false,
      ),
    );
  }

  void _onAdvanceAfterFeedback(
    RevisionQuizAdvanceAfterFeedback event,
    Emitter<RevisionQuizState> emit,
  ) {
    final isLast = state.currentIndex >= state.allRevisions.length - 1;
    if (isLast) {
      emit(state.copyWith(shouldPopRoute: true));
      return;
    }
    answerDraftController.clear();
    emit(
      state.copyWith(
        currentIndex: state.currentIndex + 1,
        currentRevision: RevisionQuizUI.fromDomain(
          state.allRevisions[state.currentIndex + 1],
        ),
        deepModeCTAEnabled: true,
        revealAnswerCTAEnabled: true,
        deepMode: false,
        answerRevealed: false,
        isSendAnswerCTAEnabled: false,
      ),
    );
  }

  void _onShouldPopConsumed(
    RevisionQuizShouldPopConsumed event,
    Emitter<RevisionQuizState> emit,
  ) {
    emit(state.copyWith(shouldPopRoute: false));
  }

  @override
  Future<void> close() {
    answerDraftController.dispose();
    return super.close();
  }

  Future<void> _onAnswerSent(
    RevisionQuizAnswerSent event,
    Emitter<RevisionQuizState> emit,
  ) async {
    final id = state.currentRevision?.id;
    if (id == null) return;
    await _sendAnswer(
      revisionId: id,
      answer: answerDraftController.text.trim(),
    );
    emit(
      state.copyWith(
        deepMode: false,
        shouldShowAnswerSentDisclaimer: true,
        deepModeCTAEnabled: false,
        revealAnswerCTAEnabled: true,
      ),
    );
  }
}
