import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'knowledge_card_state.freezed.dart';

@freezed
sealed class KnowledgeCardState with _$KnowledgeCardState {
  const factory KnowledgeCardState({
    @Default(true) bool isLoading,
    @Default([]) List<KnowledgeCardUI> knowledgeCards,
    @Default(false) bool isNextCTAEnabled,
    @Default(false) bool isCuriosityExpanded,
    @Default(false) bool isCommonErrorExpanded,
    @Default(true) bool shouldDisplayCuriosityTooltip,
    @Default(false) bool shouldDisplayCommonErrorTooltip,
    @Default(1) int progress,
    String? errorMessage,
  }) = _KnowledgeCardState;
}
