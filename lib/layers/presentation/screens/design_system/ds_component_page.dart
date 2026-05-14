import 'package:auto_route/auto_route.dart';
import 'package:auror/layers/presentation/screens/design_system/ds_component_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DSComponentPage extends StatelessWidget {
  const DSComponentPage({super.key, required this.demoId});

  /// Key into [DsDemoCatalog] (e.g. `action_buttons`).
  final String demoId;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: DSComponentBody(demoId: demoId),
    );
  }
}
