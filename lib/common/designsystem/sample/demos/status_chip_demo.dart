import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/chips/status_chip.dart';
import 'package:flutter/material.dart';

/// Showcases [StatusChip] for success, neutral, error, warning, and primary (brand).
class StatusChipDemo extends StatelessWidget {
  const StatusChipDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pill label with a leading status dot and semantic border tint.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Success', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const Align(
          alignment: Alignment.centerLeft,
          child: StatusChip(
            label: 'Microlearning com ciência',
            state: StatusChipState.success,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Neutral', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const Align(
          alignment: Alignment.centerLeft,
          child: StatusChip(
            label: 'Microlearning com ciência',
            state: StatusChipState.neutral,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Error', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const Align(
          alignment: Alignment.centerLeft,
          child: StatusChip(
            label: 'Microlearning com ciência',
            state: StatusChipState.error,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Warning', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const Align(
          alignment: Alignment.centerLeft,
          child: StatusChip(
            label: 'Microlearning com ciência',
            state: StatusChipState.warning,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Primary (brand)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const Align(
          alignment: Alignment.centerLeft,
          child: StatusChip(
            label: 'Microlearning com ciência',
            state: StatusChipState.primary,
          ),
        ),
      ],
    );
  }
}
