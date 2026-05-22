import 'package:auror/common/strings/guided_routes_strings.dart';
import 'package:auror/common/strings/main_launch_strings.dart';
import 'package:auror/common/strings/onboarding_learning_loop_strings.dart';
import 'package:auror/common/strings/onboarding_learning_section_strings.dart';
import 'package:auror/common/strings/onboarding_real_example_strings.dart';
import 'package:auror/layers/presentation/screens/onboardingguidedroutes/onboarding_guided_routes_body.dart';
import 'package:auror/layers/presentation/screens/onboardinglearningloop/onboarding_learning_loop_body.dart';
import 'package:auror/layers/presentation/screens/onboardinglearningsection/onboarding_learning_section_body.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OnboardingLearningLoopBody shows CTA and invokes onNext', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: OnboardingLearningLoopBody(onNext: () => taps++),
      ),
    );
    expect(find.text(onboardingLoopTitle), findsOneWidget);
    await tester.tap(find.text(ctaNext));
    expect(taps, 1);
  });

  testWidgets('OnboardingLearningSectionBody shows title and invokes onNext', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: OnboardingLearningSectionBody(onNext: () => taps++),
      ),
    );
    expect(find.text(onboardingSectionTitle), findsOneWidget);
    await tester.tap(find.text(ctaNext));
    expect(taps, 1);
  });

  testWidgets('OnboardingGuidedRoutesBody invokes onEnterApp', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: OnboardingGuidedRoutesBody(onEnterApp: () => taps++),
      ),
    );
    expect(find.text(guidedRoutesTitle), findsOneWidget);
    await tester.tap(find.text(ctaEnterApp));
    expect(taps, 1);
  });

  testWidgets('OnboardingRealExampleBody enables next after reveal', (
    tester,
  ) async {
    var nextTaps = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: OnboardingRealExampleBody(
          recallCardRevealed: false,
          onReveal: () {},
          onNext: () => nextTaps++,
          onTapError: () {},
          onTapWarning: () {},
          onTapSuccess: () {},
        ),
      ),
    );

    await tester.tap(find.text(ctaNext));
    expect(nextTaps, 0);

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: OnboardingRealExampleBody(
          recallCardRevealed: true,
          onReveal: () {},
          onNext: () => nextTaps++,
          onTapError: () {},
          onTapWarning: () {},
          onTapSuccess: () {},
        ),
      ),
    );
    await tester.tap(find.text(ctaNext));
    expect(nextTaps, 1);
  });
}
