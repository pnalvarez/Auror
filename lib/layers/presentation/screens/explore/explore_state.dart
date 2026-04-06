import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_state.freezed.dart';

@freezed
sealed class ExploreState with _$ExploreState {
  const factory ExploreState({
    @Default(true) bool isLoadingInitial,
    @Default(<String>[]) List<String> chipLabels,
    @Default(0) int selectedChipIndex,
    /// Cards plus a trailing `null` slot for the next page (TikTok-style feed).
    @Default(<KnowledgeCardDomain?>[]) List<KnowledgeCardDomain?> cardSlots,
    @Default(false) bool isLoadingCard,
    String? errorMessage,
  }) = _ExploreState;
}
