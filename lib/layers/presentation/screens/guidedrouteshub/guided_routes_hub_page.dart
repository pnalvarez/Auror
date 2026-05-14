import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_body.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_event.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_state.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_view_model.dart';
import 'package:auror/core/di/di.dart';
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
      child: BlocBuilder<GuidedRoutesHubViewModel, GuidedRoutesHubState>(
        builder: (context, state) {
          return SafeArea(
            child: GuidedRoutesHubBody(
              isLoading: state.isLoading && state.routes.isEmpty,
              routes: state.routes,
              errorMessage: state.errorMessage,
              isPremium: state.isPremium,
              onRouteTap: () {
                context.router.push(SubscriptionUpgradeRoute());
              },
            ),
          );
        },
      ),
    );
  }
}
