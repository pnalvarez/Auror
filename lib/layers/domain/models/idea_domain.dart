import 'package:auror/layers/domain/models/legacy_knowledge_card_domain.dart';

class IdeaDomain {
  const IdeaDomain({
    required this.completedCards,
    required this.incompleteCards,
    required this.totalTime,
  });

  final List<LegacyKnowledgeCardDomain> completedCards;
  final List<LegacyKnowledgeCardDomain> incompleteCards;
  final int totalTime;
}
