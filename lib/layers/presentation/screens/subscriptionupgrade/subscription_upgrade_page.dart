import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_event.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_view_model.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SubscriptionUpgradePage extends StatelessWidget {
  const SubscriptionUpgradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<SubscriptionUpgradeViewModel>()
            ..add(const SubscriptionUpgradeEvent.started()),
      child: Theme(
        data: mainLaunchDarkTheme(),
        child: const _SubscriptionUpgradeContent(),
      ),
    );
  }
}

class _SubscriptionUpgradeContent extends StatelessWidget {
  const _SubscriptionUpgradeContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SubscriptionUpgradeViewModel>();
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: DsNavigationBar(
          leadingIcon: Icons.arrow_back,
          leadingIconColor: scheme.onSurface,
          trailingIconColor: scheme.onSurface,
          onLeadingTap: () => context.router.maybePop(),
          title: 'Desbloqueio o Auror completo',
          description: 'Aprenda sem limites',
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: AppSpacings.m),
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacings.l,
              AppSpacings.m,
              AppSpacings.l,
              AppSpacings.xl2,
            ),
            itemBuilder: (context, index) {
              final item = viewModel.state.subscriptions[index];
              return ListItem(
                input: TitleDescriptionCheckpointsInput(
                  style: viewModel.getStyle(subscriptionId: item.id),
                  title: item.title,
                  description: item.description,
                  checkpoints: item.benefits,
                  ctaText: item.ctaText,
                  onTapCTA: () => viewModel.add(
                    SubscriptionUpgradeEvent.selected(id: item.id),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: AppSpacings.m);
            },
            itemCount: viewModel.state.subscriptions.length,
          ),
        ),
      ),
    );
  }
}
