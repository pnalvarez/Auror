import 'package:auror/common/strings/subscription_upgrade_strings.dart';
import 'package:auror/layers/domain/models/subscription_domain.dart';

class SubscriptionUI {
  SubscriptionUI({
    required this.id,
    required this.isSelected,
    required this.disabled,
    required this.title,
    required this.description,
    required this.benefits,
    required this.hasDowngradeOption,
    this.price,
    this.period,
    this.primaryCtaText,
    this.tertiaryCtaText,
    this.footerText,
  });

  final String id;
  final bool isSelected;
  final bool disabled;
  final String title;
  final String description;
  final String? price;
  final String? period;
  final List<String> benefits;
  final String? primaryCtaText;
  final String? tertiaryCtaText;
  final String? footerText;
  final bool hasDowngradeOption;

  factory SubscriptionUI.fromDomain(
    SubscriptionDomain domain, {
    bool greaterThanCurrent = false,
  }) {
    return SubscriptionUI(
      id: domain.id,
      title: domain.subscriptionName,
      isSelected: domain.isCurrent,
      disabled: !domain.isCurrent && !domain.isPaid,
      price: domain.isPaid ? domain.price.toCurrency() : null,
      period: domain.isPaid ? domain.period.toPeriod() : null,
      description: domain.description,
      benefits: domain.benefits,
      primaryCtaText: domain.isPaid && !domain.isCurrent && greaterThanCurrent
          ? subscriptionUpgradeCtaSubscribeNow
          : null,
      tertiaryCtaText: (domain.isPaid && domain.isCurrent)
          ? cancel
          : !greaterThanCurrent && domain.isPaid
          ? downgrade
          : null,
      footerText: domain.isPaid && greaterThanCurrent && !domain.isCurrent
          ? subscriptionUpgradeFooterCancelAnytime
          : null,
      hasDowngradeOption: !greaterThanCurrent && domain.isPaid,
    );
  }

  static String _periodFromDays(int days) {
    if (days >= 365) return year;
    if (days >= 30) return month;
    return day;
  }

  /// [priceCents] em centavos (ex. API `price_cents`). Ex.: `1990` → `R$ 19,90`.
  static String _toCurrency(int priceCents) {
    final reais = priceCents ~/ 100;
    final centavos = priceCents.abs() % 100;
    final centStr = centavos.toString().padLeft(2, '0');
    return 'R\$ $reais,$centStr';
  }
}

extension _PeriodFromDays on int {
  String toPeriod() => SubscriptionUI._periodFromDays(this);
}

extension _ToCurrency on int {
  String toCurrency() => SubscriptionUI._toCurrency(this);
}
