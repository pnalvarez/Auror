import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Gray placeholder rectangle with a shimmer sweep for loading states.
///
/// Use for skeleton rows, cards, or list items while content is loading.
class ShimmerRectangle extends StatelessWidget {
  const ShimmerRectangle({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  /// When null, expands horizontally inside [Row]/[Column] parents.
  final double? width;

  final double height;

  final BorderRadius? borderRadius;

  /// Shimmer base gray; defaults to theme-aware neutral surface tokens.
  final Color? baseColor;

  /// Shimmer highlight; defaults to a lighter gray than [baseColor].
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final resolvedBase = baseColor ?? _defaultBaseColor(context);
    final resolvedHighlight =
        highlightColor ?? _defaultHighlightColor(context, resolvedBase);
    final shape = borderRadius ?? BorderRadius.circular(AppRadius.s);

    return Shimmer.fromColors(
      baseColor: resolvedBase,
      highlightColor: resolvedHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: resolvedBase,
          borderRadius: shape,
        ),
      ),
    );
  }

  static Color _defaultBaseColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (scheme.brightness == Brightness.dark) {
      // Lighter gray block on dark teal/navy surfaces.
      return Color.lerp(scheme.surface, scheme.onSurface, 0.28)!;
    }
    // Darker gray block on light mint-tinted surfaces.
    return AppColors.Surface.surfaceDim;
  }

  static Color _defaultHighlightColor(BuildContext context, Color base) {
    final scheme = Theme.of(context).colorScheme;
    if (scheme.brightness == Brightness.dark) {
      return Color.lerp(scheme.surface, scheme.onSurface, 0.62)!;
    }
    // Bright sweep against [surfaceDim] base.
    return AppColors.Surface.surfaceContainerLowest;
  }
}
