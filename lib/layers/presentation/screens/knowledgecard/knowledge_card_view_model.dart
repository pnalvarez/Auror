import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_event.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class KnowledgeCardViewModel extends Bloc<KnowledgeCardEvent, KnowledgeCardState> {
  KnowledgeCardViewModel() : super(KnowledgeCardState.initial) {
    on<KnowledgeCardLoadRequested>(_onLoadRequested);
    on<KnowledgeCardDidClickCuriosity>(_onDidClickCuriosity);
    on<KnowledgeCardDidClickCommonError>(_onDidClickCommonError);
    on<KnowledgeCardDidClickNext>(_onDidClickNext);
  }

  bool _didExpandCuriosity = false;
  bool _didExpandCommonError = false;

  bool get _isNextCtaEnabled => _didExpandCuriosity && _didExpandCommonError;

  Future<void> _onLoadRequested(
    KnowledgeCardLoadRequested event,
    Emitter<KnowledgeCardState> emit,
  ) async {
    emit(KnowledgeCardState.loading(state));
    try {
      emit(KnowledgeCardState.loaded(state));
    } catch (e) {
      emit(
        KnowledgeCardState.failure(
          state,
          message: e.toString(),
        ),
      );
    }
  }

  void _onDidClickCuriosity(
    KnowledgeCardDidClickCuriosity event,
    Emitter<KnowledgeCardState> emit,
  ) {
    _didExpandCuriosity = true;
    emit(
      KnowledgeCardState.curiosityExpanded(
        base: state,
        showCommonErrorTooltip: !_didExpandCommonError,
        isNextCtaEnabled: _isNextCtaEnabled,
      ),
    );
  }

  void _onDidClickCommonError(
    KnowledgeCardDidClickCommonError event,
    Emitter<KnowledgeCardState> emit,
  ) {
    _didExpandCommonError = true;
    emit(
      KnowledgeCardState.commonErrorExpanded(
        base: state,
        isNextCtaEnabled: _isNextCtaEnabled,
      ),
    );
  }

  void _onDidClickNext(
    KnowledgeCardDidClickNext event,
    Emitter<KnowledgeCardState> emit,
  ) {
    final nextState = KnowledgeCardState.advancedToNextCard(state);
    if (nextState != null) {
      emit(nextState);
    }
  }
}

