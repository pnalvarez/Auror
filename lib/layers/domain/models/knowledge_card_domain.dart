import 'package:auror/layers/domain/models/quiz_domain.dart';

/// Knowledge card with embedded quiz (guided routes / submodule flow).
class KnowledgeCardDomain {
  const KnowledgeCardDomain({
    required this.id,
    required this.title,
    required this.description,
    required this.curiosity,
    required this.commonError,
    required this.quiz,
  });

  final String id;
  final String title;
  final String description;
  final String curiosity;
  final String commonError;
  final QuizDomain quiz;
}
