import 'package:auto_route/auto_route.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/sample/ds_demo_catalog.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DSComponentPage extends StatelessWidget {
  const DSComponentPage({super.key, required this.demoId});

  /// Key into [DsDemoCatalog] (e.g. `action_buttons`).
  final String demoId;

  @override
  Widget build(BuildContext context) {
    final entry = DsDemoCatalog.lookup(demoId);
    if (entry == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Demo')),
        body: Center(
          child: Text(
            'Unknown demo: $demoId',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(entry.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacings.xl2),
        child: entry.demo,
      ),
    );
  }
}
