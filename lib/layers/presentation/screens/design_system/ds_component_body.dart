import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/sample/ds_demo_catalog.dart';
import 'package:flutter/material.dart';

/// Scaffold + demo content for [DSComponentPage] (no routing).
class DSComponentBody extends StatelessWidget {
  const DSComponentBody({super.key, required this.demoId});

  final String demoId;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final entry = DsDemoCatalog.lookup(demoId);
    if (entry == null) {
      return Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          backgroundColor: scheme.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: const Text('Demo'),
        ),
        body: Center(
          child: Text(
            'Unknown demo: $demoId',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: scheme.onSurface),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(entry.title),
      ),
      body: demoId == 'navigation_bar'
          ? Padding(
              padding: const EdgeInsets.all(AppSpacings.xl2),
              child: SizedBox.expand(child: entry.demo),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacings.xl2),
              child: entry.demo,
            ),
    );
  }
}
