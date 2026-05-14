import 'package:auto_route/auto_route.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/onboardinglearningloop/onboarding_learning_loop_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingLearningLoopPage extends StatelessWidget {
  const OnboardingLearningLoopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: OnboardingLearningLoopBody(
        onNext: () =>
            context.router.push(const OnboardingLearningSectionRoute()),
      ),
    );
  }
}
