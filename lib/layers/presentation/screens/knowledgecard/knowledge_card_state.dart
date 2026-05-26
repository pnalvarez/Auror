import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'knowledge_card_state.freezed.dart';

@freezed
sealed class KnowledgeCardState with _$KnowledgeCardState {
  const KnowledgeCardState._();

  const factory KnowledgeCardState({
    @Default(true) bool isLoading,
    @Default([]) List<KnowledgeCardUI> knowledgeCards,
    @Default(false) bool isNextCTAEnabled,
    @Default(false) bool isCuriosityExpanded,
    @Default(false) bool isCommonErrorExpanded,
    @Default(true) bool shouldDisplayCuriosityTooltip,
    @Default(false) bool shouldDisplayCommonErrorTooltip,
    @Default(false) bool shouldNavigateToQuiz,
    @Default(1) int progress,
    String? errorMessage,
  }) = _KnowledgeCardState;

  static const initial = KnowledgeCardState();

  static KnowledgeCardState loading(KnowledgeCardState base) => base.copyWith(
        isLoading: true,
        errorMessage: null,
      );

  static KnowledgeCardState loaded(KnowledgeCardState base) => base.copyWith(
        isLoading: false,
        errorMessage: null,
      );

  static KnowledgeCardState failure(
    KnowledgeCardState base, {
    required String message,
  }) =>
      base.copyWith(
        isLoading: false,
        errorMessage: message,
      );

  static KnowledgeCardState curiosityExpanded({
    required KnowledgeCardState base,
    required bool showCommonErrorTooltip,
    required bool isNextCtaEnabled,
  }) =>
      base.copyWith(
        isCuriosityExpanded: true,
        shouldDisplayCuriosityTooltip: false,
        shouldDisplayCommonErrorTooltip: showCommonErrorTooltip,
        isNextCTAEnabled: isNextCtaEnabled,
      );

  static KnowledgeCardState commonErrorExpanded({
    required KnowledgeCardState base,
    required bool isNextCtaEnabled,
  }) =>
      base.copyWith(
        isCommonErrorExpanded: true,
        shouldDisplayCommonErrorTooltip: false,
        isNextCTAEnabled: isNextCtaEnabled,
      );

  /// Returns `null` when already on the last card.
  static KnowledgeCardState? advancedToNextCard(KnowledgeCardState base) {
    if (base.progress >= base.knowledgeCards.length) {
      return null;
    }
    return base.copyWith(progress: base.progress + 1);
  }
}
