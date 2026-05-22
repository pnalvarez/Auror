import 'package:auto_route/auto_route.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/onboardinglearningsection/onboarding_learning_section_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingLearningSectionPage extends StatelessWidget {
  const OnboardingLearningSectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: OnboardingLearningSectionBody(
        onNext: () => context.router.push(OnboardingRealExampleRoute()),
      ),
    );
  }
}
