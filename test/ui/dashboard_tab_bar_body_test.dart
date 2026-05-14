import 'package:auror/common/strings/dashboard_strings.dart';
import 'package:auror/layers/presentation/screens/dashboard/dashboard_tab_bar_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DashboardTabBarBody reports selected index', (tester) async {
    var selected = 0;
    final scheme = mainLaunchDarkTheme().colorScheme;

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: DashboardTabBarBody(
            scheme: scheme,
            specs: const [
              DashboardTabSpec(label: home, icon: Icons.home_outlined),
              DashboardTabSpec(label: profile, icon: Icons.person_outline),
            ],
            selectedIndex: selected,
            onSelectIndex: (i) => selected = i,
          ),
        ),
      ),
    );

    await tester.tap(find.text(profile));
    expect(selected, 1);
  });
}
