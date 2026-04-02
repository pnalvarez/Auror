import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:flutter/material.dart';

/// Selects which brand palette drives fill, border, and label color for action buttons.
enum ButtonBrand {
  primary,
  secondary,
  tertiary,
  error,
}

/// Resolved [ButtonBrand] colors for filled / outlined / text buttons.
@immutable
class BrandButtonColors {
  const BrandButtonColors({
    required this.fill,
    required this.onFill,
  });

  /// Main brand tone (background for primary, border + label for secondary/tertiary).
  final Color fill;

  /// Contrasting label on filled surfaces (primary button).
  final Color onFill;

  static BrandButtonColors of(ButtonBrand brand) {
    return switch (brand) {
      ButtonBrand.primary => BrandButtonColors(
          fill: AppColors.Primary.primary,
          onFill: AppColors.Primary.onPrimary,
        ),
      ButtonBrand.secondary => BrandButtonColors(
          fill: AppColors.Secondary.secondary,
          onFill: AppColors.Secondary.onSecondary,
        ),
      ButtonBrand.tertiary => BrandButtonColors(
          fill: AppColors.Tertiary.tertiary,
          onFill: AppColors.Tertiary.onTertiary,
        ),
      ButtonBrand.error => BrandButtonColors(
          fill: AppColors.Error.error,
          onFill: AppColors.Error.onError,
        ),
    };
  }

  /// Muted tones for the disabled state (desaturated toward neutral grey).
  BrandButtonColors disabled() {
    const neutral = Color(0xFF9E9E9E);
    return BrandButtonColors(
      fill: Color.lerp(fill, neutral, 0.5)!,
      onFill: Color.lerp(onFill, neutral, 0.4)!,
    );
  }
}
