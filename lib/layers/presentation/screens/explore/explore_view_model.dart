import 'package:auror/common/strings/explore_strings.dart';
import 'package:auror/layers/domain/models/category_domain.dart';
import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/domain/usecases/get_categories.dart';
import 'package:auror/layers/domain/usecases/get_next_card.dart';
import 'package:auror/layers/presentation/screens/explore/explore_event.dart';
import 'package:auror/layers/presentation/screens/explore/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Same idea as [package:bloc_concurrency/sequential.dart]: one handler at a time.
EventTransformer<ExploreEvent> _exploreSequential() {
  return (events, mapper) => events.asyncExpand(mapper);
}

@injectable
class ExploreViewModel extends Bloc<ExploreEvent, ExploreState> {
  ExploreViewModel(this._getCategories, this._getNextCard)
    : super(const ExploreState()) {
    // Single stream + sequential transformer so chip / page / load events never
    // interleave (default Bloc transformer runs separate `on<SubEvent>` handlers concurrently).
    on<ExploreEvent>(_onEvent, transformer: _exploreSequential());
  }

  final IGetCategories _getCategories;
  final IGetNextCard _getNextCard;
  List<CategoryDomain> _categories = [];

  int? _loadingSlotIndex;

  Future<void> _onEvent(ExploreEvent event, Emitter<ExploreState> emit) async {
    switch (event) {
      case ExploreStarted():
        await _onStarted(emit);
      case ExploreChipSelected(:final index):
        await _onChipSelected(index, emit);
      case ExplorePageBecameVisible(:final index):
        await _onPageBecameVisible(index, emit);
    }
  }

  Future<void> _onStarted(
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(isLoadingInitial: true, errorMessage: null));
    try {
      _categories = await _getCategories();
      final firstCard = await _getNextCard();
      final labels = [exploreChipAll, ..._categories.map((c) => c.name)];
      emit(
        state.copyWith(
          isLoadingInitial: false,
          chipLabels: labels,
          selectedChipIndex: 0,
          cardSlots: [firstCard, null],
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingInitial: false,
          chipLabels: const [],
          cardSlots: const [],
          errorMessage: exploreLoadError,
        ),
      );
    }
  }

  Future<void> _onChipSelected(
    int index,
    Emitter<ExploreState> emit,
  ) async {
    if (index < 0 || index >= state.chipLabels.length) {
      return;
    }
    if (index == state.selectedChipIndex) {
      return;
    }
    emit(
      state.copyWith(
        selectedChipIndex: index,
        isLoadingCard: true,
        errorMessage: null,
      ),
    );
    try {
      final KnowledgeCardDomain card = await _getNextCard();
      if (isClosed) {
        return;
      }
      final s = state;
      emit(
        ExploreState(
          isLoadingInitial: s.isLoadingInitial,
          chipLabels: s.chipLabels,
          selectedChipIndex: index,
          cardSlots: [card, null],
          isLoadingCard: false,
          errorMessage: null,
          feedRevision: s.feedRevision + 1,
        ),
      );
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(isLoadingCard: false, errorMessage: exploreLoadError),
      );
    }
  }

  Future<void> _onPageBecameVisible(
    int index,
    Emitter<ExploreState> emit,
  ) async {
    await _ensureSlotLoaded(index, emit);
  }

  Future<void> _ensureSlotLoaded(int index, Emitter<ExploreState> emit) async {
    final slots = state.cardSlots;
    if (index < 0 || index >= slots.length) {
      return;
    }
    if (slots[index] != null) {
      return;
    }
    if (_loadingSlotIndex == index) {
      return;
    }
    _loadingSlotIndex = index;
    emit(state.copyWith(isLoadingCard: true, errorMessage: null));
    try {
      final KnowledgeCardDomain card = await _getNextCard();
      final next = List<KnowledgeCardDomain?>.from(state.cardSlots);
      if (index >= next.length || next[index] != null) {
        emit(state.copyWith(isLoadingCard: false));
        return;
      }
      next[index] = card;
      if (index == next.length - 1) {
        next.add(null);
      }
      emit(state.copyWith(cardSlots: next, isLoadingCard: false));
    } catch (_) {
      emit(
        state.copyWith(isLoadingCard: false, errorMessage: exploreLoadError),
      );
    } finally {
      _loadingSlotIndex = null;
    }
  }
}
