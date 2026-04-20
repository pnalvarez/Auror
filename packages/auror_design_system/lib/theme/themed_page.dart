import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

class AppThemedPage extends StatelessWidget {
  final Widget child;

  const AppThemedPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final mainTheme = mainLaunchDarkTheme();

    return Theme(
      data: mainTheme,
      child: Material(
        color: mainTheme.scaffoldBackgroundColor,
        child: SafeArea(child: child),
      ),
    );
  }
}
