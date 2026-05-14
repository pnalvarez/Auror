import 'package:auror/layers/presentation/screens/design_system/ds_menu_sample_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DsMenuSampleBody reports selected demo id', (tester) async {
    String? selected;

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: DsMenuSampleBody(
            onDemoSelected: (id) => selected = id,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Action buttons'));
    expect(selected, 'action_buttons');
  });
}
