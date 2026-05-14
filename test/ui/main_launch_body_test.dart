import 'package:auror/common/strings/main_launch_strings.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_body.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MainLaunchLoadingBody shows circular loader', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Theme(
          data: mainLaunchDarkTheme(),
          child: const Scaffold(body: MainLaunchLoadingBody()),
        ),
      ),
    );

    expect(find.byType(CircularLoader), findsOneWidget);
  });

  testWidgets('MainLaunchReadyBody shows enter CTA when no session', (
    tester,
  ) async {
    var enterTaps = 0;
    var howTaps = 0;
    var dsTaps = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Theme(
          data: mainLaunchDarkTheme(),
          child: Scaffold(
            body: MainLaunchReadyBody(
              hasActiveSession: false,
              showDesignSystemCatalog: true,
              onEnterApp: () => enterTaps++,
              onHowItWorks: () => howTaps++,
              onOpenDesignSystem: () => dsTaps++,
            ),
          ),
        ),
      ),
    );

    expect(find.text(badgePill), findsOneWidget);
    expect(find.text(ctaEnterApp), findsOneWidget);
    expect(find.text(ctaDesignSystem), findsOneWidget);

    await tester.tap(find.text(ctaEnterApp));
    await tester.tap(find.text(ctaHowItWorks));
    await tester.tap(find.text(ctaDesignSystem));
    expect(enterTaps, 1);
    expect(howTaps, 1);
    expect(dsTaps, 1);
  });

  testWidgets('MainLaunchReadyBody shows continue CTA when session active', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Theme(
          data: mainLaunchDarkTheme(),
          child: Scaffold(
            body: MainLaunchReadyBody(
              hasActiveSession: true,
              showDesignSystemCatalog: false,
              onEnterApp: () {},
              onHowItWorks: () {},
              onOpenDesignSystem: () {},
            ),
          ),
        ),
      ),
    );

    expect(find.text(ctaContinueStudying), findsOneWidget);
    expect(find.text(ctaEnterApp), findsNothing);
  });
}
