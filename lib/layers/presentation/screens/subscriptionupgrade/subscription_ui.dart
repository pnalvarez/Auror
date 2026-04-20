import 'package:auror/layers/domain/models/subscription_domain.dart';

class SubscriptionUI {
  SubscriptionUI({
    required this.id,
    required this.isSelected,
    required this.title,
    required this.description,
    required this.benefits,
    this.price,
    this.period,
    this.ctaText,
    this.footerText,
  });

  final String id;
  final bool isSelected;
  final String title;
  final String description;
  final String? price;
  final String? period;
  final List<String> benefits;
  final String? ctaText;
  final String? footerText;

  factory SubscriptionUI.fromDomain(SubscriptionDomain domain) {
    return SubscriptionUI(
      id: domain.id,
      title: domain.subscriptionName,
      isSelected: domain.isCurrent,
      price: domain.price,
      period: domain.period,
      description: domain.description,
      benefits: domain.benefits,
      ctaText: domain.isPaid ? 'Assinar agora' : null,
      footerText: domain.isPaid
          ? 'Cancele quando quiser. Sem compromisso'
          : null,
    );
  }
}
