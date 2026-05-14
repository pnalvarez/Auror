import 'package:auror/layers/presentation/screens/design_system/ds_component_body.dart';
import 'package:auror_design_system/sample/ds_demo_catalog.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DSComponentBody shows unknown message for bad demoId', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: const DSComponentBody(demoId: '__unknown__'),
      ),
    );

    expect(find.textContaining('Unknown demo:'), findsOneWidget);
  });

  testWidgets('DSComponentBody shows catalog title for known demoId', (
    tester,
  ) async {
    final entry = DsDemoCatalog.lookup('badge');
    expect(entry, isNotNull);

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: const DSComponentBody(demoId: 'badge'),
      ),
    );

    expect(find.text(entry!.title), findsOneWidget);
  });
}
