import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/success/success_body.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

/// Shown after the last revision’s “Finalizar” confirmation; summarizes the session
/// and returns the user to [DashboardHomeRoute] via the bottom tab bar.
@RoutePage()
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key, required this.revisionCount});

  final int revisionCount;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: Scaffold(
        body: SafeArea(
          child: SuccessPageBody(
            revisionCount: revisionCount,
            onBackToToday: () => _popQuizAndSelectHome(context),
          ),
        ),
      ),
    );
  }

  void _popQuizAndSelectHome(BuildContext context) {
    context.router.root.navigate(
      const DashboardRoute(children: [DashboardHomeRoute()]),
    );
  }
}
