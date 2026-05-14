import 'package:auror/layers/domain/usecases/get_next_card.dart';
import 'package:auror/layers/domain/usecases/knowledge_card_mock_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns one of mock cards', () async {
    final card = await GetNextCard().call();
    expect(
      kMockKnowledgeCardDomains.any((c) => c.id == card.id),
      isTrue,
    );
  });
}
