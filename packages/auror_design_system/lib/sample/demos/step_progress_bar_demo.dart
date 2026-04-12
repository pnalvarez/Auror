import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/progress/step_progress_bar.dart';
import 'package:flutter/material.dart';

/// Showcases [StepProgressBar] fill ratios and optional label.
class StepProgressBarDemo extends StatelessWidget {
  const StepProgressBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thin track with primary fill and a right-aligned current/total label.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('1 / 3 (one third)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const StepProgressBar(currentValue: 1, totalValue: 3),
        const SizedBox(height: AppSpacings.xl2),
        Text('2 / 3', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const StepProgressBar(currentValue: 2, totalValue: 3),
        const SizedBox(height: AppSpacings.xl2),
        Text('3 / 3 (complete)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const StepProgressBar(currentValue: 3, totalValue: 3),
        const SizedBox(height: AppSpacings.xl2),
        Text('Bar only (no label)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const StepProgressBar(currentValue: 1, totalValue: 4, showLabel: false),
      ],
    );
  }
}
