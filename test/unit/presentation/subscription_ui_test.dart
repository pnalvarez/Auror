import 'package:auror/common/strings/subscription_upgrade_strings.dart';
import 'package:auror/layers/domain/models/subscription_domain.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fixtures.dart';

void main() {
  test('fromDomain builds CTA labels for paid tiers', () {
    final current = kFixtureSubscriptionDomain(id: 'cur', isCurrent: true, price: 100);
    final upgrade = kFixtureSubscriptionDomain(id: 'up', isCurrent: false, price: 200);

    final currentUi = SubscriptionUI.fromDomain(current, greaterThanCurrent: true);
    final upgradeUi = SubscriptionUI.fromDomain(upgrade, greaterThanCurrent: true);
    final downgradeUi = SubscriptionUI.fromDomain(
      kFixtureSubscriptionDomain(id: 'low', isCurrent: false, price: 50),
      greaterThanCurrent: false,
    );

    expect(currentUi.isSelected, isTrue);
    expect(currentUi.tertiaryCtaText, cancel);
    expect(upgradeUi.primaryCtaText, subscriptionUpgradeCtaSubscribeNow);
    expect(upgradeUi.footerText, subscriptionUpgradeFooterCancelAnytime);
    expect(downgradeUi.hasDowngradeOption, isTrue);
    expect(downgradeUi.tertiaryCtaText, downgrade);
    expect(upgradeUi.price, 'R\$ 2,00');
    expect(upgradeUi.period, month);
  });

  test('free plan omits price', () {
    final free = SubscriptionUI.fromDomain(
      SubscriptionDomain(
        id: 'free',
        subscriptionName: 'Free',
        description: '',
        isPaid: false,
        benefits: const [],
        isCurrent: false,
        price: 0,
        period: 7,
      ),
    );
    expect(free.price, isNull);
    expect(free.disabled, isTrue);
  });
}
