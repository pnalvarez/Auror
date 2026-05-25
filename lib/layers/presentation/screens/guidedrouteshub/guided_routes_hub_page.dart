import 'package:auror/common/utils/app_themed_page.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_body.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_event.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_state.dart';
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
      create: (_) => getIt<GuidedRoutesHubViewModel>(),
      child: const _GuidedRoutesHubScaffold(),
    );
  }
}

class _GuidedRoutesHubScaffold extends StatefulWidget {
  const _GuidedRoutesHubScaffold();

  @override
  State<_GuidedRoutesHubScaffold> createState() => _GuidedRoutesHubScaffoldState();
}

class _GuidedRoutesHubScaffoldState extends State<_GuidedRoutesHubScaffold>
    with AutoRouteAwareStateMixin<_GuidedRoutesHubScaffold> {
  void _dispatchLoadRequested() {
    context.read<GuidedRoutesHubViewModel>().add(
      const GuidedRoutesHubEvent.loadRequested(),
    );
  }

  @override
  void didInitTabRoute(TabPageRoute? previousRoute) {
    _dispatchLoadRequested();
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {
    _dispatchLoadRequested();
  }

  @override
  void didPopNext() {
    _dispatchLoadRequested();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuidedRoutesHubViewModel, GuidedRoutesHubState>(
      builder: (context, state) {
        return AppThemedPage(
          child: SafeArea(
          child: GuidedRoutesHubBody(
            isLoading: state.isLoading && state.routes.isEmpty,
            routes: state.routes,
            errorMessage: state.errorMessage,
            isUserPremium: state.isUserPremium,
            onRouteTap: (route) {
              if (route.isPremium && !state.isUserPremium) {
                context.router.push(SubscriptionUpgradeRoute());
                return;
              }
              context.router.push(
                GuidedRouteOverviewRoute(guidedRouteId: route.id),
              );
            },
          ),
          ));
      },
    );
  }
}
