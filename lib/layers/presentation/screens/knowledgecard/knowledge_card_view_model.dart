import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_event.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class KnowledgeCardViewModel extends Bloc<KnowledgeCardEvent, KnowledgeCardState> {
  KnowledgeCardViewModel() : super(const KnowledgeCardState()) {
    on<KnowledgeCardLoadRequested>(_onLoadRequested);
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
}

