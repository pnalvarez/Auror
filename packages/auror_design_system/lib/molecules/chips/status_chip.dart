import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Semantic state for [StatusChip] (dot + optional border tint).
enum StatusChipState {
  success,
  neutral,
  error,
  warning,

  /// Brand / primary accent (teal) — dot + border tint from [AppColors.Primary].
  primary,
}

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    required this.state,
    this.hasDot = true,
  });

  final String label;
  final StatusChipState state;

  /// When false, only the label is shown; border tint still reflects [state].
  final bool hasDot;

  static const double _minHeight = 32;
  static const double _dotSize = 6;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = _StatusChipAccent.of(state, scheme);
    final borderColor = Color.lerp(
          scheme.outline.withValues(alpha: 0.65),
          accent.borderTint,
          0.42,
        ) ??
        scheme.outline;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.full(_minHeight)),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _minHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacings.m,
            vertical: AppSpacings.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasDot) ...[
                Container(
                  width: _dotSize,
                  height: _dotSize,
                  decoration: BoxDecoration(
                    color: accent.dot,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacings.xs),
              ],
              Text(
                label,
                style: tagS.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
class _StatusChipAccent {
  const _StatusChipAccent({
    required this.dot,
    required this.borderTint,
  });

  final Color dot;
  final Color borderTint;

  static _StatusChipAccent of(StatusChipState state, ColorScheme scheme) {
    return switch (state) {
      StatusChipState.success => _StatusChipAccent(
          dot: AppColors.Success.success,
          borderTint: AppColors.Success.success,
        ),
      StatusChipState.neutral => _StatusChipAccent(
          dot: scheme.onSurfaceVariant,
          borderTint: scheme.outline,
        ),
      StatusChipState.error => _StatusChipAccent(
          dot: AppColors.Error.error,
          borderTint: AppColors.Error.error,
        ),
      StatusChipState.warning => _StatusChipAccent(
          dot: AppColors.Tertiary.tertiary,
          borderTint: AppColors.Warning.warning,
        ),
      StatusChipState.primary => _StatusChipAccent(
          dot: AppColors.Primary.primary,
          borderTint: AppColors.Primary.primary,
        ),
    };
  }
}
