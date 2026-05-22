import 'package:auror/layers/domain/models/idea_track_flow_args.dart';
import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fixtures.dart';

void main() {
  final cards = [
    kFixtureKnowledgeCard,
    const KnowledgeCardDomain(
      id: 'card-2',
      category: 'Cat',
      title: 'Second',
      quote: 'Q2',
      description: 'D2',
      videoUrl: 'v2',
      practicalExample: 'P2',
      commonError: 'E2',
    ),
  ];

  test('step helpers and advance', () {
    final args = IdeaTrackFlowArgs(cards: cards, currentIndex: 0);

    expect(args.totalCards, 2);
    expect(args.currentStepOneBased, 1);
    expect(args.hasNextCard, isTrue);

    final next = args.advanceToNextCard();
    expect(next.currentIndex, 1);
    expect(next.hasNextCard, isFalse);
    expect(next.advanceToNextCard(), next);
  });

  test('equality and hashCode', () {
    final a = IdeaTrackFlowArgs(cards: cards, currentIndex: 0);
    final b = IdeaTrackFlowArgs(cards: cards, currentIndex: 0);
    final c = IdeaTrackFlowArgs(cards: cards, currentIndex: 1);

    expect(a, equals(b));
    expect(a.hashCode, b.hashCode);
    expect(a, isNot(equals(c)));
  });
}
