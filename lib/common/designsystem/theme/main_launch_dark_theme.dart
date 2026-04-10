import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:flutter/material.dart';

/// Dark theme used by [MainLaunchPage] and aligned flows: teal-tinted surfaces
/// and [AppColors.Primary] as the accent axis.
ThemeData mainLaunchDarkTheme() {
  final base = ColorScheme.fromSeed(
    seedColor: AppColors.Primary.primary,
    brightness: Brightness.dark,
  );
  final tealBg = AppColors.Inverse.inverseSurface;
  return ThemeData(
    useMaterial3: true,
    colorScheme: base.copyWith(
      primary: AppColors.Primary.primary,
      onPrimary: AppColors.Primary.onPrimary,
      primaryContainer: AppColors.Primary.primary.withValues(alpha: 0.22),
      onPrimaryContainer: AppColors.Primary.primaryFixed,
      tertiary: AppColors.Tertiary.tertiary,
      onTertiary: AppColors.Tertiary.onTertiary,
      surface: Color.lerp(const Color(0xFF060908), tealBg, 0.55)!,
      surfaceContainerLowest: Color.lerp(
        const Color(0xFF060908),
        tealBg,
        0.55,
      )!,
      surfaceContainerLow: Color.lerp(const Color(0xFF0A1211), tealBg, 0.72)!,
      surfaceContainer: Color.lerp(const Color(0xFF0E1816), tealBg, 0.78)!,
      surfaceContainerHigh: Color.lerp(const Color(0xFF121F1D), tealBg, 0.82)!,
      surfaceContainerHighest: Color.lerp(
        const Color(0xFF162623),
        tealBg,
        0.86,
      )!,
      onSurface: AppColors.Inverse.onInverseSurface,
      onSurfaceVariant: AppColors.Text.Inverse.secondary,
      outline: AppColors.Primary.primary.withValues(alpha: 0.38),
      outlineVariant: AppColors.Primary.primaryFixedDim.withValues(alpha: 0.22),
    ),
  );
}
