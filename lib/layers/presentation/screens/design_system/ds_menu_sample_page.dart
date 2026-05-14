import 'package:auto_route/auto_route.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/design_system/ds_menu_sample_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DsMenuSamplePage extends StatelessWidget {
  const DsMenuSamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: Builder(
        builder: (context) {
          final scheme = Theme.of(context).colorScheme;
          return Scaffold(
            backgroundColor: scheme.surface,
            appBar: AppBar(
              backgroundColor: scheme.surface,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              title: const Text('Design system'),
            ),
            body: DsMenuSampleBody(
              onDemoSelected: (demoId) =>
                  context.router.push(DSComponentRoute(demoId: demoId)),
            ),
          );
        },
      ),
    );
  }
}
