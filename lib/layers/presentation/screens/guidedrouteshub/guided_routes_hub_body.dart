import 'package:auror/common/strings/guided_routes_hub_strings.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_ui.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:flutter/material.dart';

/// List + cards for [GuidedRoutesHubPage]. Navigation stays in the page via [onRouteTap].
class GuidedRoutesHubBody extends StatelessWidget {
  const GuidedRoutesHubBody({
    super.key,
    required this.isLoading,
    required this.routes,
    this.errorMessage,
    required this.isPremium,
    required this.onRouteTap,
  });

  final bool isLoading;
  final List<GuidedRouteIntroUI> routes;
  final String? errorMessage;
  final bool isPremium;
  final VoidCallback onRouteTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (isLoading && routes.isEmpty) {
      return Center(
        child: CircularProgressIndicator(color: scheme.primary),
      );
    }
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacings.xl2),
          child: Text(
            guidedRoutesHubLoadErrorMessage,
            textAlign: TextAlign.center,
            style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: DsNavigationBar(
        title: 'Rotas guiadas',
        description:
            'Trilhas de 5 dias para desenvolver habilidades de carreira no seu ritmo.',
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
          itemCount: routes.length + 1,
          separatorBuilder: (context, _) => const SizedBox(height: AppSpacings.l),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Text(
                guidedRoutesHubDiscoverHeading,
                style: subtitle6.copyWith(color: scheme.onSurfaceVariant),
              );
            }
            final routeIndex = index - 1;
            final route = routes[routeIndex];
            return _GuidedRouteCard(
              route: route,
              isPremium: isPremium,
              onTap: onRouteTap,
            );
          },
        ),
      ),
    );
  }
}

class _GuidedRouteCard extends StatelessWidget {
  const _GuidedRouteCard({
    required this.route,
    required this.isPremium,
    required this.onTap,
  });

  final GuidedRouteIntroUI route;
  final VoidCallback onTap;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return ListItem(
      isExpanded: true,
      padding: const EdgeInsets.all(AppSpacings.xl2),
      input: BadgesTitleDescriptionInput(
        topMainBadgeText: route.topic,
        topSecondBadgeText: isPremium ? 'Premium' : null,
        title: route.title,
        description: route.description,
        trailingIcon: isPremium ? Icons.lock_outline_rounded : Icons.lock,
      ),
      onTap: onTap,
    );
  }
}
