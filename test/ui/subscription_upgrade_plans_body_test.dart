import 'package:auror/common/strings/subscription_upgrade_strings.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_plans_body.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_ui.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SubscriptionUpgradePlansBody wires CTAs', (tester) async {
    SubscriptionUI? primaryTarget;
    SubscriptionUI? tertiaryTarget;

    final item = SubscriptionUI(
      id: subscriptionUpgradeIdStandard,
      isSelected: false,
      disabled: false,
      title: 'Standard',
      description: 'Desc',
      benefits: const ['A'],
      hasDowngradeOption: false,
      primaryCtaText: 'Go',
      tertiaryCtaText: 'Cancel sub',
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: SubscriptionUpgradePlansBody(
            subscriptions: [item],
            itemKeyForId: (_) => null,
            styleForId: (_) => TitleDescriptionCheckpointsInputStyle.standard,
            onPrimaryCta: (i) => primaryTarget = i,
            onTertiaryCta: (i) => tertiaryTarget = i,
          ),
        ),
      ),
    );

    expect(find.text('Standard'), findsOneWidget);
    await tester.tap(find.text('Go'));
    expect(primaryTarget?.id, subscriptionUpgradeIdStandard);

    await tester.tap(find.text('Cancel sub'));
    expect(tertiaryTarget?.id, subscriptionUpgradeIdStandard);
  });
}
