import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fixtures.dart';

void main() {
  test('equality compares content fields not id', () {
    const a = KnowledgeCardDomain(
      id: '1',
      category: 'Cat',
      title: 'T',
      quote: 'Q',
      description: 'D',
      videoUrl: 'v',
      practicalExample: 'P',
      commonError: 'E',
    );
    const b = KnowledgeCardDomain(
      id: '2',
      category: 'Cat',
      title: 'T',
      quote: 'Q',
      description: 'D',
      videoUrl: 'v',
      practicalExample: 'P',
      commonError: 'E',
    );

    expect(a, equals(b));
    expect(a.hashCode, b.hashCode);
  });

  test('inequality when a field differs', () {
    const other = KnowledgeCardDomain(
      id: 'card-1',
      category: 'Cat',
      title: 'Other title',
      quote: 'Quote',
      description: 'Desc',
      videoUrl: 'https://example.com/video.mp4',
      practicalExample: 'Example',
      commonError: 'Error',
    );
    expect(kFixtureKnowledgeCard, isNot(equals(other)));
  });
}
