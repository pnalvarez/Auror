import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/domain/usecases/save_recall_card.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_event.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecallCardViewModel extends Bloc<RecallCardEvent, RecallCardState> {
  RecallCardViewModel(@factoryParam this.card, this._saveRecallCard)
    : super(
        const RecallCardState(
          shouldFloatingButtonAppear: false,
        ),
      ) {
    on<PracticalExampleExpansionChanged>(_onPracticalExampleExpansionChanged);
    on<CommonErrorExpansionChanged>(_onCommonErrorExpansionChanged);
    on<ProceedCtaViewportVisibilityChanged>(
      _onProceedCtaViewportVisibilityChanged,
    );
    on<DidTapProceedCTA>(_onDidTapProceedCTA);
  }

  final KnowledgeCardDomain card;
  final ISaveRecallCard _saveRecallCard;

  /// Drives tooltip sequencing (set true after any open/close on practical example).
  bool _didExpandPracticalExample = false;

  /// True once each dropdown has been opened (expanded) at least once.
  bool _hasExpandedPracticalExample = false;
  bool _hasExpandedCommonError = false;

  /// Until the first layout pass reports otherwise, assume the proceed CTA is on
  /// screen so the floating shortcut stays hidden.
  bool _proceedCtaVisibleInViewport = true;

  RecallCardState _withFloatingButton(RecallCardState next) {
    return next.copyWith(
      shouldFloatingButtonAppear:
          _hasExpandedPracticalExample &&
          _hasExpandedCommonError &&
          !_proceedCtaVisibleInViewport,
    );
  }

  void _onPracticalExampleExpansionChanged(
    PracticalExampleExpansionChanged event,
    Emitter<RecallCardState> emit,
  ) {
    if (event.expanded) {
      _hasExpandedPracticalExample = true;
    }
    emit(
      _withFloatingButton(
        state.copyWith(
          shouldDisplayPracticalExampleTooltip: false,
          shouldDisplayCommonErrorTooltip: !_didExpandPracticalExample,
          isCommonErrorDropdownEnabled: true,
        ),
      ),
    );
    _didExpandPracticalExample = true;
  }

  void _onCommonErrorExpansionChanged(
    CommonErrorExpansionChanged event,
    Emitter<RecallCardState> emit,
  ) {
    if (event.expanded) {
      _hasExpandedCommonError = true;
    }
    emit(
      _withFloatingButton(
        state.copyWith(
          shouldDisplayCommonErrorTooltip: false,
          isProceedCTAEnabled: true,
        ),
      ),
    );
  }

  void _onProceedCtaViewportVisibilityChanged(
    ProceedCtaViewportVisibilityChanged event,
    Emitter<RecallCardState> emit,
  ) {
    if (_proceedCtaVisibleInViewport == event.isVisible) {
      return;
    }
    _proceedCtaVisibleInViewport = event.isVisible;
    emit(_withFloatingButton(state));
  }

  Future<void> _onDidTapProceedCTA(
    DidTapProceedCTA event,
    Emitter<RecallCardState> emit,
  ) async {
    emit(_withFloatingButton(state.copyWith(isLoading: true)));
    try {
      await _saveRecallCard(cardId: card.id);
      emit(
        _withFloatingButton(
          state.copyWith(isLoading: false, shouldRedirectTorRevisionQuiz: true),
        ),
      );
    } catch (e) {
      emit(
        _withFloatingButton(
          state.copyWith(isLoading: false, shouldDisplayErrorMessage: true),
        ),
      );
    }
  }
}
