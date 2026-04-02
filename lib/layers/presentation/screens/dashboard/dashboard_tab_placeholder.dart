import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Shared layout for dashboard tab shells: main-launch dark surface and centered label.
class DashboardTabPlaceholder extends StatelessWidget {
  const DashboardTabPlaceholder({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: Center(
        child: Text(
          label,
          style: headlineM.copyWith(color: scheme.onSurface),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
