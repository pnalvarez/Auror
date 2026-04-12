import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Single rounded card: inset primary accent rail, step chip, title, and body.
///
/// Tints rail and chip from [ThemeData.colorScheme.primary] / [ColorScheme.onPrimary].
class DisclaimerCard extends StatelessWidget {
  const DisclaimerCard({
    super.key,
    required this.step,
    required this.title,
    required this.description,
  });

  final int step;
  final String title;
  final String description;

  static const double _circleSize = 32;
  static const double _accentBarWidth = 3;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final titleStyle = subtitleXs.copyWith(
      color: scheme.onSurface,
      fontWeight: FontWeight.w700,
      height: 1.25,
    );
    final bodyStyle = body2Light.copyWith(
      color: scheme.onSurfaceVariant,
      height: 1.45,
    );

    final outline = AppColors.Primary.primary.withValues(alpha: 0.18);

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.l),
        border: Border.all(color: outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacings.l),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: _accentBarWidth,
                color: scheme.primary,
              ),
              const SizedBox(width: AppSpacings.m),
              Container(
                width: _circleSize,
                height: _circleSize,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$step',
                  style: labelM.copyWith(
                    color: scheme.onPrimary,
                    height: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacings.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: titleStyle),
                    const SizedBox(height: AppSpacings.s),
                    Text(description, style: bodyStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
