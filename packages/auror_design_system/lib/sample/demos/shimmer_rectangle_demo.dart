import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/feedback/shimmer_rectangle.dart';
import 'package:flutter/material.dart';

/// Demo of [ShimmerRectangle] sizes for loading placeholders.
class ShimmerRectangleDemo extends StatelessWidget {
  const ShimmerRectangleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Gray skeleton blocks with a shimmer animation for loading states.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Single line', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const ShimmerRectangle(width: double.infinity, height: 14),
        const SizedBox(height: AppSpacings.xl2),
        Text('Title + body', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const ShimmerRectangle(width: 180, height: 20),
        const SizedBox(height: AppSpacings.s),
        const ShimmerRectangle(width: double.infinity, height: 12),
        const SizedBox(height: AppSpacings.s),
        const ShimmerRectangle(width: 240, height: 12),
        const SizedBox(height: AppSpacings.xl2),
        Text('Card skeleton', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ShimmerRectangle(
          width: double.infinity,
          height: 120,
          borderRadius: BorderRadius.circular(AppRadius.m),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('List item skeleton', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerRectangle(
              width: 48,
              height: 48,
              borderRadius: BorderRadius.circular(AppRadius.m),
            ),
            const SizedBox(width: AppSpacings.m),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ShimmerRectangle(height: 16),
                  SizedBox(height: AppSpacings.s),
                  ShimmerRectangle(width: 120, height: 12),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
