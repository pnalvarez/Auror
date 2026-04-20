class SubscriptionDomain {
  SubscriptionDomain({
    required this.id,
    required this.subscriptionName,
    required this.description,
    required this.isPaid,
    required this.benefits,
    required this.isCurrent,
    this.price,
    this.period,
  });

  final String id;
  final String subscriptionName;
  final String description;
  final bool isPaid;
  final List<String> benefits;
  final bool isCurrent;
  final String? price;
  final String? period;
}
