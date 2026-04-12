import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Semantic fill for [DsTooltip] (brand primary vs state colors).
enum DsTooltipBrand {
  /// Brand teal fill ([AppColors.Primary]).
  neutral,

  /// Positive — green.
  success,

  /// Caution — amber.
  warning,

  /// Destructive — red.
  error,
}

/// Where the balloon sits relative to [child] and where the tail sits on the
/// balloon edge (start / center / end in reading direction).
enum DsTooltipPlacement {
  /// Balloon above [child]; tail on the bottom edge toward the start side.
  startTop,

  /// Balloon below [child]; tail on the top edge toward the start side.
  startBottom,

  /// Balloon above [child]; tail centered on the bottom edge.
  centerTop,

  /// Balloon below [child]; tail centered on the top edge.
  centerBottom,

  /// Balloon above [child]; tail on the bottom edge toward the end side.
  endTop,

  /// Balloon below [child]; tail on the top edge toward the end side.
  endBottom,
}

/// Horizontal position of the balloon tail on its edge (mirrors [DsTooltipPlacement]).
enum DsTooltipTailAlignment {
  start,
  center,
  end,
}

bool _placementIsAbove(DsTooltipPlacement p) => switch (p) {
  DsTooltipPlacement.startTop ||
  DsTooltipPlacement.centerTop ||
  DsTooltipPlacement.endTop =>
    true,
  _ => false,
};

CrossAxisAlignment _placementColumnAlign(DsTooltipPlacement p) =>
    switch (p) {
      DsTooltipPlacement.startTop ||
      DsTooltipPlacement.startBottom =>
        CrossAxisAlignment.start,
      DsTooltipPlacement.centerTop ||
      DsTooltipPlacement.centerBottom =>
        CrossAxisAlignment.center,
      DsTooltipPlacement.endTop ||
      DsTooltipPlacement.endBottom =>
        CrossAxisAlignment.end,
    };

DsTooltipTailAlignment _placementTailAlignment(DsTooltipPlacement p) {
  switch (p) {
    case DsTooltipPlacement.startTop:
    case DsTooltipPlacement.startBottom:
      return DsTooltipTailAlignment.start;
    case DsTooltipPlacement.centerTop:
    case DsTooltipPlacement.centerBottom:
      return DsTooltipTailAlignment.center;
    case DsTooltipPlacement.endTop:
    case DsTooltipPlacement.endBottom:
      return DsTooltipTailAlignment.end;
  }
}

/// Small text balloon with a tail aimed at a [child] widget.
///
/// The tooltip is **not** an overlay: it participates in layout (column above
/// or below the anchor).
class DsTooltip extends StatelessWidget {
  const DsTooltip({
    super.key,
    required this.text,
    required this.child,
    this.placement = DsTooltipPlacement.centerBottom,
    this.brand = DsTooltipBrand.neutral,
    this.maxWidth = 280,
    this.visible = true,
  });

  final String text;
  final Widget child;
  final DsTooltipPlacement placement;
  final DsTooltipBrand brand;
  final double maxWidth;
  final bool visible;

  static const double _tailHeight = 6;
  static const double _tailWidth = 12;
  static const double _gap = 2;

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = _resolveBrand(brand);
    final direction = Directionality.of(context);

    final bubble = _TooltipBubble(
      text: text,
      backgroundColor: bg,
      textColor: fg,
      tailOnTop: !_placementIsAbove(placement),
      tailAlignment: _placementTailAlignment(placement),
      textDirection: direction,
      maxWidth: maxWidth,
      tailHeight: _tailHeight,
      tailWidth: _tailWidth,
    );

    final align = _placementColumnAlign(placement);

    // Always keep the same [Column] shape + child slot so toggling [visible]
    // does not reparent [child] and reset [State] (e.g. [DsDropdown]).
    if (_placementIsAbove(placement)) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: align,
        children: [
          if (visible) bubble else const SizedBox.shrink(),
          if (visible) SizedBox(height: _gap) else const SizedBox.shrink(),
          child,
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: align,
      children: [
        child,
        if (visible) SizedBox(height: _gap) else const SizedBox.shrink(),
        if (visible) bubble else const SizedBox.shrink(),
      ],
    );
  }
}

(Color, Color) _resolveBrand(DsTooltipBrand brand) {
  return switch (brand) {
    DsTooltipBrand.neutral => (
      AppColors.Primary.primaryContainer,
      AppColors.Primary.onPrimary,
    ),
    DsTooltipBrand.success => (
      AppColors.Success.onSuccess,
      AppColors.Success.success,
    ),
    DsTooltipBrand.warning => (
      AppColors.Warning.onWarning,
      AppColors.Warning.warning,
    ),
    DsTooltipBrand.error => (AppColors.Error.onError, AppColors.Error.error),
  };
}

class _TooltipBubble extends StatelessWidget {
  const _TooltipBubble({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.tailOnTop,
    required this.tailAlignment,
    required this.textDirection,
    required this.maxWidth,
    required this.tailHeight,
    required this.tailWidth,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool tailOnTop;
  final DsTooltipTailAlignment tailAlignment;
  final TextDirection textDirection;
  final double maxWidth;
  final double tailHeight;
  final double tailWidth;

  TextAlign get _textAlign => switch (tailAlignment) {
    DsTooltipTailAlignment.start => TextAlign.start,
    DsTooltipTailAlignment.center => TextAlign.center,
    DsTooltipTailAlignment.end => TextAlign.end,
  };

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacings.s;
    final vPad = AppSpacings.xs;

    final verticalPadding = EdgeInsets.fromLTRB(
      hPad,
      vPad + (tailOnTop ? tailHeight : 0),
      hPad,
      vPad + (tailOnTop ? 0 : tailHeight),
    );

    return CustomPaint(
      painter: _TooltipBubblePainter(
        color: backgroundColor,
        tailOnTop: tailOnTop,
        tailAlignment: tailAlignment,
        textDirection: textDirection,
        borderRadius: AppRadius.s,
        tailWidth: tailWidth,
        tailHeight: tailHeight,
      ),
      child: Padding(
        padding: verticalPadding,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Text(
            text,
            textAlign: _textAlign,
            style: tagS.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}

class _TooltipBubblePainter extends CustomPainter {
  _TooltipBubblePainter({
    required this.color,
    required this.tailOnTop,
    required this.tailAlignment,
    required this.textDirection,
    required this.borderRadius,
    required this.tailWidth,
    required this.tailHeight,
  });

  final Color color;
  final bool tailOnTop;
  final DsTooltipTailAlignment tailAlignment;
  final TextDirection textDirection;
  final double borderRadius;
  final double tailWidth;
  final double tailHeight;

  double _tailCenterX(double width) {
    final inset = (borderRadius + tailWidth * 0.35).clamp(
      tailWidth / 2 + 2,
      width / 2 - 1,
    );
    switch (tailAlignment) {
      case DsTooltipTailAlignment.start:
        return textDirection == TextDirection.ltr ? inset : width - inset;
      case DsTooltipTailAlignment.center:
        return width / 2;
      case DsTooltipTailAlignment.end:
        return textDirection == TextDirection.ltr ? width - inset : inset;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final body = Path();
    final tail = Path();
    final cx = _tailCenterX(size.width);

    if (tailOnTop) {
      body.addRRect(
        RRect.fromLTRBR(
          0,
          tailHeight,
          size.width,
          size.height,
          Radius.circular(borderRadius),
        ),
      );
      tail
        ..moveTo(cx - tailWidth / 2, tailHeight)
        ..lineTo(cx, 0)
        ..lineTo(cx + tailWidth / 2, tailHeight)
        ..close();
    } else {
      final bodyH = size.height - tailHeight;
      body.addRRect(
        RRect.fromLTRBR(0, 0, size.width, bodyH, Radius.circular(borderRadius)),
      );
      tail
        ..moveTo(cx - tailWidth / 2, bodyH)
        ..lineTo(cx, size.height)
        ..lineTo(cx + tailWidth / 2, bodyH)
        ..close();
    }

    final path = Path.combine(PathOperation.union, body, tail);
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is! _TooltipBubblePainter) {
      return true;
    }
    return oldDelegate.color != color ||
        oldDelegate.tailOnTop != tailOnTop ||
        oldDelegate.tailAlignment != tailAlignment ||
        oldDelegate.textDirection != textDirection ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.tailWidth != tailWidth ||
        oldDelegate.tailHeight != tailHeight;
  }
}
