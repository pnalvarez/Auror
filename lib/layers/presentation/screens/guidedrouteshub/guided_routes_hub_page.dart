import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:auror/common/strings/guided_routes_hub_strings.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_event.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_state.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_ui.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Guided routes list (embedded under [DashboardRoutesPage]).
@RoutePage()
class GuidedRoutesHubPage extends StatelessWidget {
  const GuidedRoutesHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<GuidedRoutesHubViewModel>()
            ..add(const GuidedRoutesHubEvent.loadRequested()),
      child: const _GuidedRoutesHubBody(),
    );
  }
}

class _GuidedRoutesHubBody extends StatelessWidget {
  const _GuidedRoutesHubBody();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: BlocBuilder<GuidedRoutesHubViewModel, GuidedRoutesHubState>(
        builder: (context, state) {
          if (state.isLoading && state.routes.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: scheme.primary),
            );
          }
          if (state.errorMessage != null) {
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
                itemCount: state.routes.length + 1,
                separatorBuilder: (context, _) =>
                    const SizedBox(height: AppSpacings.l),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Text(
                      guidedRoutesHubDiscoverHeading,
                      style: subtitle6.copyWith(color: scheme.onSurfaceVariant),
                    );
                  }
                  final routeIndex = index - 1;
                  final route = state.routes[routeIndex];
                  return _GuidedRouteCard(
                    route: route,
                    isPremium: state.isPremium,
                    onTap: () {
                      context.router.push(SubscriptionUpgradeRoute());
                    },
                  );
                },
              ),
            ),
          );
        },
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
