// Design system API intentionally uses PascalCase namespaces (e.g. AppColors.Success.success)
// to mirror Material role names and read like nested types.
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

/// Design system colors for [auror].
///
/// Hierarchical access: [AppColors.Success.success], [AppColors.Text.Error.onContainer], etc.
///
/// Naming follows [Material Design 3](https://m3.material.io/styles/color/roles) where applicable.
/// [Success] and [Warning] mirror [Error] (fill + container pairs).
///
/// Values default to a **light** appearance. Map into [ColorScheme] / [ThemeData] for dark mode.
///
/// **Note:** Dart does not allow nested `class` declarations; namespaces are `const` palette objects
/// on [AppColors] (same usage style as `AppColors.Success.success`).
abstract final class AppColors {
  AppColors._();

  static const Primary = _PrimaryPalette();
  static const Secondary = _SecondaryPalette();
  static const Tertiary = _TertiaryPalette();
  static const Quaternary = _QuaternaryPalette();
  static const Surface = _SurfacePalette();
  static const Inverse = _InversePalette();
  static const Outline = _OutlinePalette();
  static const Elevation = _ElevationPalette();
  static const Error = _ErrorPalette();
  static const Success = _SuccessPalette();
  static const Warning = _WarningPalette();
  static const Text = _TextPalette();

  /// Dark navy surfaces with muted gold accents (screens, cards, icon wells).
  static const DarkContent = _DarkContentPalette();

  /// Full Material 3 [ColorScheme] for light [ThemeData], mapped from DS tokens.
  static ColorScheme get lightColorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: Primary.primary,
    onPrimary: Primary.onPrimary,
    primaryContainer: Primary.primaryContainer,
    onPrimaryContainer: Primary.onPrimaryContainer,
    primaryFixed: Primary.primaryFixed,
    primaryFixedDim: Primary.primaryFixedDim,
    onPrimaryFixed: Primary.onPrimaryFixed,
    onPrimaryFixedVariant: Primary.onPrimaryFixedVariant,
    secondary: Secondary.secondary,
    onSecondary: Secondary.onSecondary,
    secondaryContainer: Secondary.secondaryContainer,
    onSecondaryContainer: Secondary.onSecondaryContainer,
    secondaryFixed: Secondary.secondaryFixed,
    secondaryFixedDim: Secondary.secondaryFixedDim,
    onSecondaryFixed: Secondary.onSecondaryFixed,
    onSecondaryFixedVariant: Secondary.onSecondaryFixedVariant,
    tertiary: Tertiary.tertiary,
    onTertiary: Tertiary.onTertiary,
    tertiaryContainer: Tertiary.tertiaryContainer,
    onTertiaryContainer: Tertiary.onTertiaryContainer,
    tertiaryFixed: Tertiary.tertiaryFixed,
    tertiaryFixedDim: Tertiary.tertiaryFixedDim,
    onTertiaryFixed: Tertiary.onTertiaryFixed,
    onTertiaryFixedVariant: Tertiary.onTertiaryFixedVariant,
    error: Error.error,
    onError: Error.onError,
    errorContainer: Error.errorContainer,
    onErrorContainer: Error.onErrorContainer,
    surface: Surface.surface,
    onSurface: Surface.onSurface,
    surfaceDim: Surface.surfaceDim,
    surfaceBright: Surface.surfaceBright,
    surfaceContainerLowest: Surface.surfaceContainerLowest,
    surfaceContainerLow: Surface.surfaceContainerLow,
    surfaceContainer: Surface.surfaceContainer,
    surfaceContainerHigh: Surface.surfaceContainerHigh,
    surfaceContainerHighest: Surface.surfaceContainerHighest,
    onSurfaceVariant: Surface.onSurfaceVariant,
    outline: Outline.outline,
    outlineVariant: Outline.outlineVariant,
    shadow: Elevation.shadow,
    scrim: Elevation.scrim,
    inverseSurface: Inverse.inverseSurface,
    onInverseSurface: Inverse.onInverseSurface,
    inversePrimary: Inverse.inversePrimary,
    surfaceTint: Primary.primary,
  );
}

// --- Brand ------------------------------------------------------------------

@immutable
class _PrimaryPalette {
  const _PrimaryPalette();

  /// Brand anchor: vivid teal (micro-learning / clarity / focus).
  final Color primary = const Color(0xFF00CEC8);

  /// Dark teal for strong contrast on the bright primary (AA-friendly body text).
  final Color onPrimary = const Color(0xFF003D38);
  final Color primaryContainer = const Color(0xFFCCFBF9);
  final Color onPrimaryContainer = const Color(0xFF004D48);

  final Color primaryFixed = const Color(0xFFB2F7F4);
  final Color onPrimaryFixed = const Color(0xFF002E2B);
  final Color primaryFixedDim = const Color(0xFF5DD5CF);
  final Color onPrimaryFixedVariant = const Color(0xFF006B64);
}

@immutable
class _SecondaryPalette {
  const _SecondaryPalette();

  /// Desaturated slate blue: structure without competing with long-form text.
  final Color secondary = const Color(0xFF5C7384);
  final Color onSecondary = const Color(0xFFFFFFFF);
  final Color secondaryContainer = const Color(0xFFE2E9EE);
  final Color onSecondaryContainer = const Color(0xFF0F2433);

  final Color secondaryFixed = const Color(0xFFE2E9EE);
  final Color onSecondaryFixed = const Color(0xFF0F2433);
  final Color secondaryFixedDim = const Color(0xFFC8D4DE);
  final Color onSecondaryFixedVariant = const Color(0xFF3A5568);
}

@immutable
class _TertiaryPalette {
  const _TertiaryPalette();

  /// Soft amber: rewards and highlights with less visual punch for long sessions.
  final Color tertiary = const Color(0xFFEDC001);
  final Color onTertiary = const Color(0xFF3A2A00);
  final Color tertiaryContainer = const Color(0xFFF5E6D4);
  final Color onTertiaryContainer = const Color(0xFF3D2608);

  final Color tertiaryFixed = const Color(0xFFF5E6D4);
  final Color onTertiaryFixed = const Color(0xFF3D2608);
  final Color tertiaryFixedDim = const Color(0xFFE8D0B3);
  final Color onTertiaryFixedVariant = const Color(0xFF7A5A28);
}

@immutable
class _QuaternaryPalette {
  const _QuaternaryPalette();

  /// Violet accent: additional brand axis beyond [Tertiary] (opaque 0xFF6C3BAA).
  final Color quaternary = const Color(0xFF6C3BAA);
  final Color onQuaternary = const Color(0xFFFFFFFF);
  final Color quaternaryContainer = const Color(0xFFF0E4F8);
  final Color onQuaternaryContainer = const Color(0xFF240840);

  final Color quaternaryFixed = const Color(0xFFF0E4F8);
  final Color onQuaternaryFixed = const Color(0xFF240840);
  final Color quaternaryFixedDim = const Color(0xFFE2D0F0);
  final Color onQuaternaryFixedVariant = const Color(0xFF5C4580);
}

// --- Dark content (navy + gold) ---------------------------------------------

@immutable
class _DarkContentPalette {
  const _DarkContentPalette();

  final Color background = const Color(0xFF0B0E14);
  final Color surface = const Color(0xFF161B22);
  final Color accent = const Color(0xFFB89352);
  final Color iconWell = const Color(0xFF0D1117);
}

// --- Surfaces & structure ---------------------------------------------------

@immutable
class _SurfacePalette {
  const _SurfacePalette();

  /// Cool, slightly teal-tinted neutrals (aligned with primary #00CEC8).
  final Color surface = const Color(0xFFF7FBFB);
  final Color onSurface = const Color(0xFF1C1B1F);
  final Color surfaceDim = const Color(0xFFD0E0DE);
  final Color surfaceBright = const Color(0xFFF7FBFB);

  final Color surfaceContainerLowest = const Color(0xFFFFFFFF);
  final Color surfaceContainerLow = const Color(0xFFF1F8F7);
  final Color surfaceContainer = const Color(0xFFEBF5F4);
  final Color surfaceContainerHigh = const Color(0xFFE4EFEE);
  final Color surfaceContainerHighest = const Color(0xFFDDE8E7);

  final Color onSurfaceVariant = const Color(0xFF4A5F5D);

  Color get surfaceTint => AppColors.Primary.primary;
}

@immutable
class _InversePalette {
  const _InversePalette();

  final Color inverseSurface = const Color(0xFF1C2B2A);
  final Color onInverseSurface = const Color(0xFFE8F3F2);
  final Color inversePrimary = const Color(0xFF5EEAD4);
}

@immutable
class _OutlinePalette {
  const _OutlinePalette();

  final Color outline = const Color(0xFF6F8583);
  final Color outlineVariant = const Color(0xFFBFD5D3);
}

@immutable
class _ElevationPalette {
  const _ElevationPalette();

  final Color shadow = const Color(0xFF000000);
  final Color scrim = const Color(0xFF000000);
}

// --- Semantic states --------------------------------------------------------

@immutable
class _ErrorPalette {
  const _ErrorPalette();

  final Color error = const Color(0xFFB3261E);
  final Color onError = const Color(0xFFFFFFFF);
  final Color errorContainer = const Color(0xFFF9DEDC);
  final Color onErrorContainer = const Color(0xFF410E0B);
}

@immutable
class _SuccessPalette {
  const _SuccessPalette();

  final Color success = const Color(0xFF1B5E20);
  final Color onSuccess = const Color(0xFFFFFFFF);
  final Color successContainer = const Color(0xFFC8E6C9);
  final Color onSuccessContainer = const Color(0xFF002106);
}

@immutable
class _WarningPalette {
  const _WarningPalette();

  final Color warning = const Color(0xFFE65100);
  final Color onWarning = const Color(0xFFFFFFFF);
  final Color warningContainer = const Color(0xFFFFE0B2);
  final Color onWarningContainer = const Color(0xFF2D1600);
}

// --- Text -------------------------------------------------------------------

@immutable
class _TextPalette {
  const _TextPalette();

  Color get link => AppColors.Primary.primary;

  final Body = const _TextBodyPalette();
  final Inverse = const _TextInversePalette();
  final OnFill = const _TextOnFillPalette();
  final OnContainer = const _TextOnContainerPalette();
  final Error = const _TextErrorRoles();
  final Success = const _TextSuccessRoles();
  final Warning = const _TextWarningRoles();
}

@immutable
class _TextBodyPalette {
  const _TextBodyPalette();

  Color get primary => AppColors.Surface.onSurface;
  Color get secondary => AppColors.Surface.onSurfaceVariant;
  Color get tertiary => const Color(0xFF6F8583);
  Color get disabled => const Color(0x611C1B1F);
}

@immutable
class _TextInversePalette {
  const _TextInversePalette();

  Color get primary => AppColors.Inverse.onInverseSurface;
  Color get secondary => const Color(0xCCE8F3F2);
}

@immutable
class _TextOnFillPalette {
  const _TextOnFillPalette();

  Color get primary => AppColors.Primary.onPrimary;
  Color get secondary => AppColors.Secondary.onSecondary;
  Color get tertiary => AppColors.Tertiary.onTertiary;
  Color get error => AppColors.Error.onError;
  Color get success => AppColors.Success.onSuccess;
  Color get warning => AppColors.Warning.onWarning;
}

@immutable
class _TextOnContainerPalette {
  const _TextOnContainerPalette();

  Color get primary => AppColors.Primary.onPrimaryContainer;
  Color get secondary => AppColors.Secondary.onSecondaryContainer;
  Color get tertiary => AppColors.Tertiary.onTertiaryContainer;
  Color get error => AppColors.Error.onErrorContainer;
  Color get success => AppColors.Success.onSuccessContainer;
  Color get warning => AppColors.Warning.onWarningContainer;
}

@immutable
class _TextErrorRoles {
  const _TextErrorRoles();

  Color get onFill => AppColors.Error.onError;
  Color get onContainer => AppColors.Error.onErrorContainer;
}

@immutable
class _TextSuccessRoles {
  const _TextSuccessRoles();

  Color get onFill => AppColors.Success.onSuccess;
  Color get onContainer => AppColors.Success.onSuccessContainer;
}

@immutable
class _TextWarningRoles {
  const _TextWarningRoles();

  Color get onFill => AppColors.Warning.onWarning;
  Color get onContainer => AppColors.Warning.onWarningContainer;
}
