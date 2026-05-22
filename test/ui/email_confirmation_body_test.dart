import 'package:auror/layers/presentation/screens/emailconfirmation/email_confirmation_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EmailConfirmationBody invokes callback when CTA tapped', (
    tester,
  ) async {
    var taps = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: EmailConfirmationBody(
            ctaLabel: 'Abrir e-mail',
            onOpenMailbox: () => taps++,
          ),
        ),
      ),
    );

    expect(find.text('Abrir e-mail'), findsOneWidget);
    await tester.tap(find.text('Abrir e-mail'));
    expect(taps, 1);
  });
}
