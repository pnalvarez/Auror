import 'package:auror/common/utils/app_themed_page.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_body.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_event.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_state.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GuidedRouteOverviewPage extends StatelessWidget {
  const GuidedRouteOverviewPage({super.key, required this.guidedRouteId});

  final String guidedRouteId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<GuidedRouteOverviewViewModel>(param1: guidedRouteId)
            ..add(const GuidedRouteOverviewEvent.loadRequested()),
      child: BlocBuilder<GuidedRouteOverviewViewModel, GuidedRouteOverviewState>(
        builder: (context, state) {
          return AppThemedPage(
            child: GuidedRouteOverviewBody(
              state: state,
              onRetry: () => context.read<GuidedRouteOverviewViewModel>().add(
                const GuidedRouteOverviewEvent.loadRequested(),
              ),
            ),
          );
        },
      ),
    );
  }
}

