/// Knowledge card content for learning flows (domain layer).
class KnowledgeCardDomain {
  const KnowledgeCardDomain({
    required this.id,
    required this.category,
    required this.title,
    required this.quote,
    required this.description,
    required this.videoUrl,
    required this.practicalExample,
    required this.commonError,
  });

  final String id;

  final String category;

  final String title;

  final String quote;

  final String description;

  final String videoUrl;

  final String practicalExample;

  final String commonError;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is KnowledgeCardDomain &&
            category == other.category &&
            title == other.title &&
            quote == other.quote &&
            description == other.description &&
            videoUrl == other.videoUrl &&
            practicalExample == other.practicalExample &&
            commonError == other.commonError;
  }

  @override
  int get hashCode => Object.hash(
    category,
    title,
    quote,
    description,
    videoUrl,
    practicalExample,
    commonError,
  );
}
