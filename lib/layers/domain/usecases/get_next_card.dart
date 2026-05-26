import 'dart:math';

import 'package:auror/layers/domain/models/legacy_knowledge_card_domain.dart';
import 'package:auror/layers/domain/usecases/knowledge_card_mock_data.dart';
import 'package:injectable/injectable.dart';

abstract class IGetNextCard {
  Future<LegacyKnowledgeCardDomain> call();
}

@Injectable(as: IGetNextCard)
class GetNextCard implements IGetNextCard {
  @override
  Future<LegacyKnowledgeCardDomain> call() async {
    final cards = kMockKnowledgeCardDomains;
    final index = Random().nextInt(cards.length);
    return cards[index];
  }
}
