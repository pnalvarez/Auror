import 'package:auror/layers/domain/models/knowledge_card_domain.dart';

class IdeaDomain {
  const IdeaDomain({
    required this.completedCards,
    required this.incompleteCards,
    required this.totalTime,
  });

  final List<KnowledgeCardDomain> completedCards;
  final List<KnowledgeCardDomain> incompleteCards;
  final int totalTime;
}
