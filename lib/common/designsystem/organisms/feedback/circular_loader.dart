import 'package:flutter/material.dart';

/// Indeterminate circular progress for inline loading (e.g. action buttons).
///
/// [color] is the active arc—use the same token as the control’s foreground
/// (brand fill on outlined/text buttons, on-fill contrast on solid fills).
class CircularLoader extends StatelessWidget {
  const CircularLoader({
    super.key,
    required this.color,
    this.trackColor,
    this.size = 24,
    this.strokeWidth = 2,
  });

  /// Active indicator; matches label / border / on-fill contrast as needed.
  final Color color;

  /// Track behind the arc; defaults to a low-alpha tint of [color].
  final Color? trackColor;

  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final track = trackColor ?? color.withValues(alpha: 0.2);
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color,
        backgroundColor: track,
      ),
    );
  }
}
