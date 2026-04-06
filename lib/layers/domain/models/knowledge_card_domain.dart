/// Knowledge card content for learning flows (domain layer).
class KnowledgeCardDomain {
  const KnowledgeCardDomain({
    required this.category,
    required this.title,
    required this.quote,
    required this.description,
    required this.videoUrl,
    required this.practicalExample,
    required this.commonError,
  });

  final String category;

  final String title;

  final String quote;

  final String description;

  final String videoUrl;

  final String practicalExample;

  final String commonError;
}
