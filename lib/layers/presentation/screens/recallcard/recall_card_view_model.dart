import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/domain/usecases/save_recall_card.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_event.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecallCardViewModel extends Bloc<RecallCardEvent, RecallCardState> {
  RecallCardViewModel(@factoryParam this.card, this._saveRecallCard)
    : super(const RecallCardState()) {
    on<PracticalExampleExpansionChanged>(_onPracticalExampleExpansionChanged);
    on<CommonErrorExpansionChanged>(_onCommonErrorExpansionChanged);
    on<DidTapProceedCTA>(_onDidTapProceedCTA);
  }

  final KnowledgeCardDomain card;
  final ISaveRecallCard _saveRecallCard;
  bool _practicalExampleExpanded = false;
  bool _commonErrorExpanded = false;

  void _onPracticalExampleExpansionChanged(
    PracticalExampleExpansionChanged event,
    Emitter<RecallCardState> emit,
  ) {
    _practicalExampleExpanded = true;
    emit(
      state.copyWith(
        isProceedCTAEnabled: _practicalExampleExpanded && _commonErrorExpanded,
      ),
    );
  }

  void _onCommonErrorExpansionChanged(
    CommonErrorExpansionChanged event,
    Emitter<RecallCardState> emit,
  ) {
    _commonErrorExpanded = true;
    emit(
      state.copyWith(
        isProceedCTAEnabled: _practicalExampleExpanded && _commonErrorExpanded,
      ),
    );
  }

  Future<void> _onDidTapProceedCTA(
    DidTapProceedCTA event,
    Emitter<RecallCardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _saveRecallCard(cardId: card.id);
      emit(
        state.copyWith(isLoading: false, shouldRedirectTorRevisionQuiz: true),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, shouldDisplayErrorMessage: true));
    }
  }
}
