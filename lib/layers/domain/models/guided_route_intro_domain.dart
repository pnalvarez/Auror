/// Single guided route card shown before starting a route (domain layer).
class GuidedRouteIntroDomain {
  const GuidedRouteIntroDomain({
    required this.topic,
    required this.isPremiumMode,
    required this.title,
    required this.description,
  });

  final String topic;
  final bool isPremiumMode;
  final String title;
  final String description;
}
