import 'package:auto_route/auto_route.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:auror/layers/presentation/screens/onboardingguidedroutes/onboarding_guided_routes_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingGuidedRoutesPage extends StatelessWidget {
  const OnboardingGuidedRoutesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: OnboardingGuidedRoutesBody(
        onEnterApp: () => context.router.push(
          LoginRoute(loginContext: LoginContext.signIn),
        ),
      ),
    );
  }
}
