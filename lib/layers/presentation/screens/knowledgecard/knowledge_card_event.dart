import 'package:freezed_annotation/freezed_annotation.dart';

part 'knowledge_card_event.freezed.dart';

@freezed
sealed class KnowledgeCardEvent with _$KnowledgeCardEvent {
  const factory KnowledgeCardEvent.loadRequested() = KnowledgeCardLoadRequested;
}

