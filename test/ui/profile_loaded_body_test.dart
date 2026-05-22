import 'package:auror/common/strings/profile_strings.dart';
import 'package:auror/layers/presentation/screens/profile/profile_loaded_body.dart';
import 'package:auror/layers/presentation/screens/profile/profile_ui.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProfileLoadedBody shows user and invokes actions', (
    tester,
  ) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => binding.setSurfaceSize(null));

    var planTaps = 0;
    var routesTaps = 0;
    var logoutTaps = 0;

    const profile = ProfileUI(
      username: 'User',
      email: 'u@example.com',
      profileImageUrl: '',
      learnedCards: 1,
      revisionsDone: 2,
      followedDays: 3,
      subscriptionPlan: 'Plano Free',
      hasUpgrade: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: ProfileLoadedBody(
            profile: profile,
            logoutLoading: false,
            onPlanRowTap: () => planTaps++,
            onMyRoutesTap: () => routesTaps++,
            onLogoutTap: () => logoutTaps++,
          ),
        ),
      ),
    );

    expect(find.text('User'), findsOneWidget);
    expect(find.text(profileLogoutLabel), findsOneWidget);

    await tester.tap(find.text('Plano Free'));
    expect(planTaps, 1);

    await tester.tap(find.text(profileNavMyRoutes));
    expect(routesTaps, 1);

    await tester.tap(find.text(profileLogoutLabel));
    expect(logoutTaps, 1);
  });
}
