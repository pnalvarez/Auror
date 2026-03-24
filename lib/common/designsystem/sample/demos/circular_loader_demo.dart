import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/feedback/circular_loader.dart';
import 'package:flutter/material.dart';

/// Demo of [CircularLoader] for filled vs neutral backgrounds.
class CircularLoaderDemo extends StatelessWidget {
  const CircularLoaderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Indeterminate ring for inline loading (e.g. action buttons).',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('On filled brand surface', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.Primary.primary,
              borderRadius: BorderRadius.circular(AppRadius.m),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacings.xl2),
              child: CircularLoader(color: AppColors.Primary.onPrimary),
            ),
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('On neutral surface', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        Center(
          child: CircularLoader(color: AppColors.Primary.primary),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Larger size', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        Center(
          child: CircularLoader(
            color: AppColors.Secondary.secondary,
            size: 40,
            strokeWidth: 3,
          ),
        ),
      ],
    );
  }
}
