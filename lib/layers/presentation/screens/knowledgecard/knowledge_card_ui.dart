import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/domain/models/quiz_domain.dart';

/// Multiple-choice quiz for [KnowledgeCardUI].
class QuizUI {
  const QuizUI({
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctAnswer,
  });

  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;

  /// `1` = [option1], …, `4` = [option4].
  final int correctAnswer;

  factory QuizUI.fromDomain(QuizDomain domain) {
    return QuizUI(
      question: domain.question,
      option1: domain.option1,
      option2: domain.option2,
      option3: domain.option3,
      option4: domain.option4,
      correctAnswer: domain.correctAnswer,
    );
  }
}

/// Presentation model for a knowledge card, mapped from [KnowledgeCardDomain].
class KnowledgeCardUI {
  const KnowledgeCardUI({
    required this.title,
    required this.description,
    required this.curiosity,
    required this.commonError,
    required this.quiz,
  });

  final String title;
  final String description;
  final String curiosity;
  final String commonError;
  final QuizUI quiz;

  factory KnowledgeCardUI.fromDomain(KnowledgeCardDomain domain) {
    return KnowledgeCardUI(
      title: domain.title,
      description: domain.description,
      curiosity: domain.curiosity,
      commonError: domain.commonError,
      quiz: QuizUI.fromDomain(domain.quiz),
    );
  }
}
