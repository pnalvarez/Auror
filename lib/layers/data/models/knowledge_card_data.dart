import 'package:auror/layers/data/models/quiz_data.dart';
import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'knowledge_card_data.g.dart';

/// Linha de `public.knowledge_cards` (REST v1 / PostgREST).
///
/// Exclui [submodule_id] e timestamps — use outro DTO ou parâmetro de rota
/// quando o vínculo com o submódulo for necessário.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class KnowledgeCardData {
  const KnowledgeCardData({
    required this.id,
    required this.title,
    required this.description,
    required this.curiosity,
    required this.commonError,
    this.quiz,
  });

  final String id;
  final String title;
  final String description;

  /// Quiz embutido pelo RPC `get_knowledge_cards_with_quizzes` (pode ser null).
  final QuizData? quiz;

  /// Coluna `curiosity` (texto de curiosidade / fato extra).
  final String curiosity;

  /// Coluna `common_error` (erro comum que o aprendiz costuma cometer).
  final String commonError;

  factory KnowledgeCardData.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeCardDataFromJson(json);

  KnowledgeCardDomain toDomain() {
    final quizData = quiz;
    if (quizData == null) {
      throw StateError('Quiz ausente para o knowledge card $id.');
    }
    return KnowledgeCardDomain(
      id: id,
      title: title,
      description: description,
      curiosity: curiosity,
      commonError: commonError,
      quiz: quizData.toDomain(),
    );
  }
}
