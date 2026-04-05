import 'package:auror/layers/domain/models/revision_domain.dart';

/// Full revision card for the quiz flow (domain layer).
class RevisionQuizUI {
  const RevisionQuizUI({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.category,
    required this.correctAnswer,
  });

  final String id;

  final String title;

  /// Network URL for the revision clip (HTTPS).
  final String videoUrl;

  final String category;

  final String correctAnswer;

  factory RevisionQuizUI.fromDomain(RevisionDomain domain) {
    return RevisionQuizUI(
      id: domain.id,
      title: domain.question,
      videoUrl: domain.videoUrl,
      category: domain.category,
      correctAnswer: domain.correctAnswer,
    );
  }
}
