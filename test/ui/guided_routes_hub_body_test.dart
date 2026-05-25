import 'package:auror/common/strings/guided_routes_hub_strings.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_body.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_ui.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GuidedRoutesHubBody shows loader when loading and empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: GuidedRoutesHubBody(
            isLoading: true,
            routes: const [],
            isUserPremium: false,
            onRouteTap: (_) {},
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('GuidedRoutesHubBody shows error copy', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: GuidedRoutesHubBody(
            isLoading: false,
            routes: const [],
            errorMessage: 'x',
            isUserPremium: false,
            onRouteTap: (_) {},
          ),
        ),
      ),
    );

    expect(find.text(guidedRoutesHubLoadErrorMessage), findsOneWidget);
  });

  testWidgets('GuidedRoutesHubBody lists routes and invokes onRouteTap', (
    tester,
  ) async {
    var taps = 0;
    const route = GuidedRouteIntroUI(
      id: 'route-1',
      topic: 'Tópico',
      title: 'Título',
      description: 'Descrição',
      isPremium: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: GuidedRoutesHubBody(
            isLoading: false,
            routes: const [route],
            isUserPremium: false,
            onRouteTap: (_) => taps++,
          ),
        ),
      ),
    );

    expect(find.text(guidedRoutesHubDiscoverHeading), findsOneWidget);
    expect(find.text('Título'), findsOneWidget);

    await tester.tap(find.text('Título'));
    expect(taps, 1);
  });
}
