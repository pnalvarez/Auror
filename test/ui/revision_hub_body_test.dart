import 'package:auror/common/strings/revision_hub_strings.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_body.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_ui.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RevisionHubBody shows loader when loading and empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: RevisionHubBody(
            isLoading: true,
            revisions: const [],
            totalMinutes: 0,
            onStartRevision: () {},
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('RevisionHubBody shows error copy', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: RevisionHubBody(
            isLoading: false,
            revisions: const [],
            errorMessage: 'e',
            totalMinutes: 0,
            onStartRevision: () {},
          ),
        ),
      ),
    );

    expect(find.text(revisionHubLoadError), findsOneWidget);
  });

  testWidgets('RevisionHubBody shows revisions and start CTA', (tester) async {
    var starts = 0;
    const revisions = [
      RevisionIntroUI(title: 'R1', minutes: '5 min'),
      RevisionIntroUI(title: 'R2', minutes: '3 min'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: RevisionHubBody(
            isLoading: false,
            revisions: revisions,
            totalMinutes: 8,
            onStartRevision: () => starts++,
          ),
        ),
      ),
    );

    expect(find.text(revisionHubTitle), findsOneWidget);
    expect(find.text(revisionHubEstimatedTime(8)), findsOneWidget);
    expect(find.text(revisionHubStartCta(2)), findsOneWidget);
    expect(find.text('R1'), findsOneWidget);
    expect(find.text('5 min'), findsOneWidget);

    await tester.tap(find.text(revisionHubStartCta(2)));
    expect(starts, 1);
  });

  testWidgets('RevisionHubBody disables start when there are no revisions', (
    tester,
  ) async {
    var starts = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: RevisionHubBody(
            isLoading: false,
            revisions: const [],
            totalMinutes: 0,
            onStartRevision: () => starts++,
          ),
        ),
      ),
    );

    expect(find.text(revisionHubStartCta(0)), findsOneWidget);
    await tester.tap(find.text(revisionHubStartCta(0)));
    expect(starts, 0);
  });
}
