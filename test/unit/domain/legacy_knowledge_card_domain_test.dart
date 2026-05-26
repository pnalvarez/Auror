import 'package:auror/layers/domain/models/legacy_knowledge_card_domain.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fixtures.dart';

void main() {
  test('equality compares content fields not id', () {
    const a = LegacyKnowledgeCardDomain(
      id: '1',
      category: 'Cat',
      title: 'T',
      quote: 'Q',
      description: 'D',
      videoUrl: 'v',
      practicalExample: 'P',
      commonError: 'E',
    );
    const b = LegacyKnowledgeCardDomain(
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
    const other = LegacyKnowledgeCardDomain(
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
