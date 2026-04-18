import 'package:auror/layers/domain/models/knowledge_card_domain.dart';

/// Context for the home “ideia do dia” flow: several recall cards, each followed
/// by its revision quiz, with a shared progress indicator.
class IdeaTrackFlowArgs {
  const IdeaTrackFlowArgs({required this.cards, required this.currentIndex})
    : assert(currentIndex >= 0, 'currentIndex must be non-negative');

  final List<KnowledgeCardDomain> cards;
  final int currentIndex;

  int get totalCards => cards.length;

  /// 1-based step index for UI (e.g. card 0 of the track → `1`).
  int get currentStepOneBased => currentIndex + 1;

  bool get hasNextCard => currentIndex < cards.length - 1;

  IdeaTrackFlowArgs advanceToNextCard() {
    if (!hasNextCard) return this;
    return IdeaTrackFlowArgs(cards: cards, currentIndex: currentIndex + 1);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is IdeaTrackFlowArgs &&
            other.currentIndex == currentIndex &&
            _listEquals(other.cards, cards);
  }

  @override
  int get hashCode => Object.hash(currentIndex, Object.hashAll(cards));

  static bool _listEquals(
    List<KnowledgeCardDomain> a,
    List<KnowledgeCardDomain> b,
  ) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
