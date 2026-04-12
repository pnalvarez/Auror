import 'package:auror/layers/domain/models/knowledge_card_domain.dart';

class IdeaDomain {
  const IdeaDomain({required this.cards, required this.totalTime});

  final List<KnowledgeCardDomain> cards;
  final int totalTime;
}
