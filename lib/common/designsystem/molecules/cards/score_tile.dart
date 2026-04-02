import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Rounded metric card: icon, large numeric score, and caption label.
///
/// Colors follow [ThemeData.colorScheme] (elevated surface, outline, primary
/// accent) so it matches main launch / dashboard and other design-system cards.
class ScoreTile extends StatelessWidget {
  const ScoreTile({
    super.key,
    required this.icon,
    required this.score,
    required this.label,
    this.iconColor,
  });

  final IconData icon;
  final int score;
  final String label;

  /// When null, uses [ColorScheme.primary].
  final Color? iconColor;

  static const double _iconSize = 28;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = iconColor ?? scheme.primary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.xl2),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.xl,
          vertical: AppSpacings.l,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: _iconSize, color: accent),
            const SizedBox(height: AppSpacings.s),
            Text('$score', style: headlineS.copyWith(color: scheme.onSurface)),
            const SizedBox(height: AppSpacings.xs),
            Text(
              label,
              textAlign: TextAlign.center,
              style: body4Light.copyWith(color: scheme.onSurfaceVariant),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
