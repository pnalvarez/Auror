import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Visual treatment for [DsBadge] (category pill vs premium accent).
enum BadgeVariant {
  /// Muted pill on elevated surface (e.g. category).
  neutral,

  /// Gold accent with optional leading icon (e.g. Premium).
  highlight,

  primary,

  secondary,

  tertiary,

  /// Semi-transparent surface on video/full-bleed media (e.g. day / link pill).
  surfaceOverlay,
}

/// Small pill label; supports optional [leadingIcon] (e.g. crown for premium).
class DsBadge extends StatelessWidget {
  const DsBadge({
    super.key,
    required this.label,
    this.leadingIcon,
    this.variant = BadgeVariant.neutral,
  });

  final String label;
  final IconData? leadingIcon;

  final BadgeVariant variant;

  static const double _minHeight = 28;
  static const double _iconSize = 14;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final (Color bg, Color fg) = switch (variant) {
      BadgeVariant.neutral => (
        scheme.surfaceContainerHighest,
        scheme.onSurfaceVariant,
      ),
      BadgeVariant.highlight => (
        AppColors.DarkContent.accent.withValues(alpha: 0.2),
        AppColors.DarkContent.accent,
      ),
      BadgeVariant.primary => (scheme.primary, scheme.onPrimary),
      BadgeVariant.secondary => (scheme.secondary, scheme.onSecondary),
      BadgeVariant.tertiary => (scheme.tertiary, scheme.onTertiary),
      BadgeVariant.surfaceOverlay => (
        scheme.surface.withValues(alpha: 0.55),
        scheme.onSurface.withValues(alpha: 0.95),
      ),
    };

    final EdgeInsetsGeometry padding = switch (variant) {
      BadgeVariant.surfaceOverlay => const EdgeInsets.symmetric(
        horizontal: AppSpacings.m,
        vertical: AppSpacings.xs,
      ),
      _ => const EdgeInsets.symmetric(
        horizontal: AppSpacings.s,
        vertical: AppSpacings.xs2,
      ),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.full(_minHeight)),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _minHeight),
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: _iconSize, color: fg),
                const SizedBox(width: AppSpacings.xs2),
              ],
              Text(label, style: tagS.copyWith(color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}
