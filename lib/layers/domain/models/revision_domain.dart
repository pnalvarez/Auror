/// Full revision card for the quiz flow (domain layer).
class RevisionDomain {
  const RevisionDomain({
    required this.id,
    required this.question,
    required this.videoUrl,
    required this.category,
    required this.minutes,
    required this.correctAnswer,
    required this.cardId,
  });

  final String id;

  final String question;

  final String videoUrl;

  final String category;

  final int minutes;

  final String correctAnswer;

  final String cardId;
}
