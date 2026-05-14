import 'package:auror/common/strings/revision_quiz_strings.dart';
import 'package:auror/layers/presentation/screens/success/success_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SuccessPageBody shows revision count and invokes callback', (
    tester,
  ) async {
    var backTaps = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Theme(
          data: mainLaunchDarkTheme(),
          child: Scaffold(
            body: SuccessPageBody(
              revisionCount: 4,
              onBackToToday: () => backTaps++,
            ),
          ),
        ),
      ),
    );

    expect(find.text(revisionQuizEndTitle), findsOneWidget);
    expect(find.textContaining('4'), findsOneWidget);
    expect(find.text(revisionQuizEndBackToToday), findsOneWidget);

    await tester.tap(find.text(revisionQuizEndBackToToday));
    expect(backTaps, 1);
  });
}
