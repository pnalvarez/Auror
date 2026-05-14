import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_ui.dart';
import 'package:flutter/material.dart';

/// Plan list for [SubscriptionUpgradePage] (listeners / scroll stay on the page).
class SubscriptionUpgradePlansBody extends StatelessWidget {
  const SubscriptionUpgradePlansBody({
    super.key,
    required this.subscriptions,
    required this.itemKeyForId,
    required this.styleForId,
    required this.onPrimaryCta,
    required this.onTertiaryCta,
  });

  final List<SubscriptionUI> subscriptions;
  final GlobalKey? Function(String subscriptionId) itemKeyForId;
  final TitleDescriptionCheckpointsInputStyle Function(String subscriptionId)
      styleForId;
  final void Function(SubscriptionUI item) onPrimaryCta;
  final void Function(SubscriptionUI item) onTertiaryCta;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacings.l,
        AppSpacings.m,
        AppSpacings.l,
        AppSpacings.xl2,
      ),
      itemBuilder: (context, index) {
        final item = subscriptions[index];
        return ListItem(
          key: itemKeyForId(item.id),
          isSelected: item.isSelected,
          isEnabled: !item.disabled,
          input: TitleDescriptionCheckpointsInput(
            style: styleForId(item.id),
            title: item.title,
            firstTrailingItem: item.price,
            secondTrailingItem: item.period,
            description: item.description,
            checkpoints: item.benefits,
            primaryCtaText: item.primaryCtaText,
            tertiaryCTAText: item.tertiaryCtaText,
            tertiaryCTAHasErrorBrandFixed: !item.hasDowngradeOption,
            onTapPrimaryCTA: () => onPrimaryCta(item),
            onTapTertiaryCTA: () => onTertiaryCta(item),
            footerText: item.footerText,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: AppSpacings.xl2);
      },
      itemCount: subscriptions.length,
    );
  }
}
