class SubscriptionDomain {
  SubscriptionDomain({
    required this.id,
    required this.subscriptionName,
    required this.description,
    required this.isPaid,
    required this.benefits,
    required this.isCurrent,
    required this.price,
    required this.period,
  });

  final String id;
  final String subscriptionName;
  final String description;
  final bool isPaid;
  final List<String> benefits;
  final bool isCurrent;
  final int price;
  final int period;
}
