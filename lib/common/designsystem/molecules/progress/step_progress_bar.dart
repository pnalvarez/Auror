import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Thin horizontal progress with a **current / total** caption aligned to the
/// end below the bar (e.g. revision or lesson step).
///
/// Track and fill follow [ThemeData.colorScheme]; use on dark surfaces as in
/// main launch / dashboard.
class StepProgressBar extends StatelessWidget {
  const StepProgressBar({
    super.key,
    required this.currentValue,
    required this.totalValue,
    this.barHeight = 3,
    this.showLabel = true,
  }) : assert(barHeight > 0);

  /// Current step (1-based in the displayed label; clamped to [totalValue]).
  final int currentValue;

  /// Total steps; must be positive for a meaningful bar.
  final int totalValue;

  /// Height of the track in logical pixels (typically 2–4).
  final double barHeight;

  /// When false, only the bar is shown (no `current/total` line).
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final safeTotal = totalValue <= 0 ? 0 : totalValue;
    final current = safeTotal == 0 ? 0 : currentValue.clamp(0, safeTotal);
    final fraction = safeTotal == 0 ? 0.0 : current / safeTotal;

    final track = scheme.surfaceContainerHighest;
    final fill = scheme.primary;
    final labelColor = scheme.onSurfaceVariant;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth * fraction;
            return ClipRRect(
              borderRadius: BorderRadius.circular(barHeight / 2),
              child: SizedBox(
                height: barHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(color: track),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: w,
                        height: barHeight,
                        child: ColoredBox(color: fill),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (showLabel) ...[
          const SizedBox(height: AppSpacings.xs),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              safeTotal == 0 ? '0/0' : '$current/$safeTotal',
              style: tagRegular.copyWith(color: labelColor, height: 1.2),
            ),
          ),
        ],
      ],
    );
  }
}
