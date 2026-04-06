import 'package:auror/common/strings/explore_strings.dart';
import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/domain/usecases/get_categories.dart';
import 'package:auror/layers/domain/usecases/get_next_card.dart';
import 'package:auror/layers/presentation/screens/explore/explore_event.dart';
import 'package:auror/layers/presentation/screens/explore/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreViewModel extends Bloc<ExploreEvent, ExploreState> {
  ExploreViewModel(
    this._getCategories,
    this._getNextCard,
  ) : super(const ExploreState()) {
    on<ExploreStarted>(_onStarted);
    on<ExploreChipSelected>(_onChipSelected);
    on<ExplorePageBecameVisible>(_onPageBecameVisible);
  }

  final IGetCategories _getCategories;
  final IGetNextCard _getNextCard;

  int? _loadingSlotIndex;

  Future<void> _onStarted(
    ExploreStarted event,
    Emitter<ExploreState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingInitial: true,
        errorMessage: null,
      ),
    );
    try {
      final categories = await _getCategories();
      final firstCard = await _getNextCard();
      final labels = [
        exploreChipAll,
        ...categories.map((c) => c.name),
      ];
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

  void _onChipSelected(
    ExploreChipSelected event,
    Emitter<ExploreState> emit,
  ) {
    if (event.index < 0 || event.index >= state.chipLabels.length) {
      return;
    }
    emit(state.copyWith(selectedChipIndex: event.index));
  }

  Future<void> _onPageBecameVisible(
    ExplorePageBecameVisible event,
    Emitter<ExploreState> emit,
  ) async {
    await _ensureSlotLoaded(event.index, emit);
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
        state.copyWith(
          isLoadingCard: false,
          errorMessage: exploreLoadError,
        ),
      );
    } finally {
      _loadingSlotIndex = null;
    }
  }
}
