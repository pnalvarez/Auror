import 'package:auror/common/strings/revision_quiz_strings.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_status_body.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RevisionQuizLoadingBody shows loader', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: const Scaffold(body: RevisionQuizLoadingBody()),
      ),
    );
    expect(find.byType(CircularLoader), findsOneWidget);
  });

  testWidgets('RevisionQuizEmptyBody shows message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: const Scaffold(body: RevisionQuizEmptyBody()),
      ),
    );
    expect(find.text(revisionQuizEmptyMessage), findsOneWidget);
  });
}
