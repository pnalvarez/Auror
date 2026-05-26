import 'package:auror/layers/domain/models/quiz_domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_data.g.dart';

/// Linha de `public.quizzes` (REST v1 / PostgREST).
///
/// Exclui [knowledge_card_id] e timestamps — passe o id do card separadamente
/// quando o vínculo for necessário.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class QuizData {
  const QuizData({
    required this.id,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctAnswer,
  });

  final String id;
  final String question;

  @JsonKey(name: 'option_1')
  final String option1;

  @JsonKey(name: 'option_2')
  final String option2;

  @JsonKey(name: 'option_3')
  final String option3;

  @JsonKey(name: 'option_4')
  final String option4;

  /// Índice da opção correta: `1` = [option1], …, `4` = [option4].
  final int correctAnswer;

  factory QuizData.fromJson(Map<String, dynamic> json) =>
      _$QuizDataFromJson(json);

  QuizDomain toDomain() => QuizDomain(
    question: question,
    option1: option1,
    option2: option2,
    option3: option3,
    option4: option4,
    correctAnswer: correctAnswer,
  );
}
