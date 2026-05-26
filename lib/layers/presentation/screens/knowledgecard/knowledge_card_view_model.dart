import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_event.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class KnowledgeCardViewModel extends Bloc<KnowledgeCardEvent, KnowledgeCardState> {
  KnowledgeCardViewModel() : super(const KnowledgeCardState()) {
    on<KnowledgeCardLoadRequested>(_onLoadRequested);
    on<KnowledgeCardDidClickCuriosity>(_onDidClickCuriosity);
    on<KnowledgeCardDidClickCommonError>(_onDidClickCommonError);
    on<KnowledgeCardDidClickNext>(_onDidClickNext);
  }

  Future<void> _onLoadRequested(
    KnowledgeCardLoadRequested event,
    Emitter<KnowledgeCardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      // TODO: load data via use cases.
      emit(state.copyWith(isLoading: false, errorMessage: null));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onDidClickCuriosity(
    KnowledgeCardDidClickCuriosity event,
    Emitter<KnowledgeCardState> emit,
  ) {}

  void _onDidClickCommonError(
    KnowledgeCardDidClickCommonError event,
    Emitter<KnowledgeCardState> emit,
  ) {}

  void _onDidClickNext(
    KnowledgeCardDidClickNext event,
    Emitter<KnowledgeCardState> emit,
  ) {}
}

