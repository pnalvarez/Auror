/// Multiple-choice quiz for a [KnowledgeCardDomain].
class QuizDomain {
  const QuizDomain({
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
}
