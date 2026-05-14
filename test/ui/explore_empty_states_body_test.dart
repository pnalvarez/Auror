import 'package:auror/common/strings/explore_strings.dart';
import 'package:auror/layers/presentation/screens/explore/explore_empty_states_body.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ExploreLoadingBody shows circular loader', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: const Scaffold(body: ExploreLoadingBody()),
      ),
    );
    expect(find.byType(CircularLoader), findsOneWidget);
  });

  testWidgets('ExploreErrorBody shows load error copy', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: const Scaffold(body: ExploreErrorBody()),
      ),
    );
    expect(find.text(exploreLoadError), findsOneWidget);
  });
}
