import 'package:freezed_annotation/freezed_annotation.dart';

part 'knowledge_card_state.freezed.dart';

@freezed
sealed class KnowledgeCardState with _$KnowledgeCardState {
  const factory KnowledgeCardState({
    @Default(true) bool isLoading,
    String? errorMessage,
  }) = _KnowledgeCardState;
}

