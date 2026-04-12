import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Full-screen swatches for [AppColors]: path string and hex on each fill.
class ColorsCatalogDemo extends StatelessWidget {
  const ColorsCatalogDemo({super.key});

  static List<({String path, Color color})> _entries() => [
        // Primary
        (path: 'AppColors.Primary.primary', color: AppColors.Primary.primary),
        (path: 'AppColors.Primary.onPrimary', color: AppColors.Primary.onPrimary),
        (
          path: 'AppColors.Primary.primaryContainer',
          color: AppColors.Primary.primaryContainer,
        ),
        (
          path: 'AppColors.Primary.onPrimaryContainer',
          color: AppColors.Primary.onPrimaryContainer,
        ),
        (path: 'AppColors.Primary.primaryFixed', color: AppColors.Primary.primaryFixed),
        (
          path: 'AppColors.Primary.onPrimaryFixed',
          color: AppColors.Primary.onPrimaryFixed,
        ),
        (
          path: 'AppColors.Primary.primaryFixedDim',
          color: AppColors.Primary.primaryFixedDim,
        ),
        (
          path: 'AppColors.Primary.onPrimaryFixedVariant',
          color: AppColors.Primary.onPrimaryFixedVariant,
        ),
        // Secondary
        (path: 'AppColors.Secondary.secondary', color: AppColors.Secondary.secondary),
        (
          path: 'AppColors.Secondary.onSecondary',
          color: AppColors.Secondary.onSecondary,
        ),
        (
          path: 'AppColors.Secondary.secondaryContainer',
          color: AppColors.Secondary.secondaryContainer,
        ),
        (
          path: 'AppColors.Secondary.onSecondaryContainer',
          color: AppColors.Secondary.onSecondaryContainer,
        ),
        (
          path: 'AppColors.Secondary.secondaryFixed',
          color: AppColors.Secondary.secondaryFixed,
        ),
        (
          path: 'AppColors.Secondary.onSecondaryFixed',
          color: AppColors.Secondary.onSecondaryFixed,
        ),
        (
          path: 'AppColors.Secondary.secondaryFixedDim',
          color: AppColors.Secondary.secondaryFixedDim,
        ),
        (
          path: 'AppColors.Secondary.onSecondaryFixedVariant',
          color: AppColors.Secondary.onSecondaryFixedVariant,
        ),
        // Tertiary
        (path: 'AppColors.Tertiary.tertiary', color: AppColors.Tertiary.tertiary),
        (path: 'AppColors.Tertiary.onTertiary', color: AppColors.Tertiary.onTertiary),
        (
          path: 'AppColors.Tertiary.tertiaryContainer',
          color: AppColors.Tertiary.tertiaryContainer,
        ),
        (
          path: 'AppColors.Tertiary.onTertiaryContainer',
          color: AppColors.Tertiary.onTertiaryContainer,
        ),
        (
          path: 'AppColors.Tertiary.tertiaryFixed',
          color: AppColors.Tertiary.tertiaryFixed,
        ),
        (
          path: 'AppColors.Tertiary.onTertiaryFixed',
          color: AppColors.Tertiary.onTertiaryFixed,
        ),
        (
          path: 'AppColors.Tertiary.tertiaryFixedDim',
          color: AppColors.Tertiary.tertiaryFixedDim,
        ),
        (
          path: 'AppColors.Tertiary.onTertiaryFixedVariant',
          color: AppColors.Tertiary.onTertiaryFixedVariant,
        ),
        // Dark content
        (
          path: 'AppColors.DarkContent.background',
          color: AppColors.DarkContent.background,
        ),
        (path: 'AppColors.DarkContent.surface', color: AppColors.DarkContent.surface),
        (path: 'AppColors.DarkContent.accent', color: AppColors.DarkContent.accent),
        (
          path: 'AppColors.DarkContent.iconWell',
          color: AppColors.DarkContent.iconWell,
        ),
        // Surface
        (path: 'AppColors.Surface.surface', color: AppColors.Surface.surface),
        (path: 'AppColors.Surface.onSurface', color: AppColors.Surface.onSurface),
        (path: 'AppColors.Surface.surfaceDim', color: AppColors.Surface.surfaceDim),
        (
          path: 'AppColors.Surface.surfaceBright',
          color: AppColors.Surface.surfaceBright,
        ),
        (
          path: 'AppColors.Surface.surfaceContainerLowest',
          color: AppColors.Surface.surfaceContainerLowest,
        ),
        (
          path: 'AppColors.Surface.surfaceContainerLow',
          color: AppColors.Surface.surfaceContainerLow,
        ),
        (
          path: 'AppColors.Surface.surfaceContainer',
          color: AppColors.Surface.surfaceContainer,
        ),
        (
          path: 'AppColors.Surface.surfaceContainerHigh',
          color: AppColors.Surface.surfaceContainerHigh,
        ),
        (
          path: 'AppColors.Surface.surfaceContainerHighest',
          color: AppColors.Surface.surfaceContainerHighest,
        ),
        (
          path: 'AppColors.Surface.onSurfaceVariant',
          color: AppColors.Surface.onSurfaceVariant,
        ),
        (path: 'AppColors.Surface.surfaceTint', color: AppColors.Surface.surfaceTint),
        // Inverse
        (
          path: 'AppColors.Inverse.inverseSurface',
          color: AppColors.Inverse.inverseSurface,
        ),
        (
          path: 'AppColors.Inverse.onInverseSurface',
          color: AppColors.Inverse.onInverseSurface,
        ),
        (
          path: 'AppColors.Inverse.inversePrimary',
          color: AppColors.Inverse.inversePrimary,
        ),
        // Outline
        (path: 'AppColors.Outline.outline', color: AppColors.Outline.outline),
        (
          path: 'AppColors.Outline.outlineVariant',
          color: AppColors.Outline.outlineVariant,
        ),
        // Elevation
        (path: 'AppColors.Elevation.shadow', color: AppColors.Elevation.shadow),
        (path: 'AppColors.Elevation.scrim', color: AppColors.Elevation.scrim),
        // Error
        (path: 'AppColors.Error.error', color: AppColors.Error.error),
        (path: 'AppColors.Error.onError', color: AppColors.Error.onError),
        (
          path: 'AppColors.Error.errorContainer',
          color: AppColors.Error.errorContainer,
        ),
        (
          path: 'AppColors.Error.onErrorContainer',
          color: AppColors.Error.onErrorContainer,
        ),
        // Success
        (path: 'AppColors.Success.success', color: AppColors.Success.success),
        (path: 'AppColors.Success.onSuccess', color: AppColors.Success.onSuccess),
        (
          path: 'AppColors.Success.successContainer',
          color: AppColors.Success.successContainer,
        ),
        (
          path: 'AppColors.Success.onSuccessContainer',
          color: AppColors.Success.onSuccessContainer,
        ),
        // Warning
        (path: 'AppColors.Warning.warning', color: AppColors.Warning.warning),
        (path: 'AppColors.Warning.onWarning', color: AppColors.Warning.onWarning),
        (
          path: 'AppColors.Warning.warningContainer',
          color: AppColors.Warning.warningContainer,
        ),
        (
          path: 'AppColors.Warning.onWarningContainer',
          color: AppColors.Warning.onWarningContainer,
        ),
        // Text
        (path: 'AppColors.Text.link', color: AppColors.Text.link),
        (path: 'AppColors.Text.Body.primary', color: AppColors.Text.Body.primary),
        (
          path: 'AppColors.Text.Body.secondary',
          color: AppColors.Text.Body.secondary,
        ),
        (path: 'AppColors.Text.Body.tertiary', color: AppColors.Text.Body.tertiary),
        (
          path: 'AppColors.Text.Body.disabled',
          color: AppColors.Text.Body.disabled,
        ),
        (
          path: 'AppColors.Text.Inverse.primary',
          color: AppColors.Text.Inverse.primary,
        ),
        (
          path: 'AppColors.Text.Inverse.secondary',
          color: AppColors.Text.Inverse.secondary,
        ),
        (
          path: 'AppColors.Text.OnFill.primary',
          color: AppColors.Text.OnFill.primary,
        ),
        (
          path: 'AppColors.Text.OnFill.secondary',
          color: AppColors.Text.OnFill.secondary,
        ),
        (
          path: 'AppColors.Text.OnFill.tertiary',
          color: AppColors.Text.OnFill.tertiary,
        ),
        (path: 'AppColors.Text.OnFill.error', color: AppColors.Text.OnFill.error),
        (
          path: 'AppColors.Text.OnFill.success',
          color: AppColors.Text.OnFill.success,
        ),
        (
          path: 'AppColors.Text.OnFill.warning',
          color: AppColors.Text.OnFill.warning,
        ),
        (
          path: 'AppColors.Text.OnContainer.primary',
          color: AppColors.Text.OnContainer.primary,
        ),
        (
          path: 'AppColors.Text.OnContainer.secondary',
          color: AppColors.Text.OnContainer.secondary,
        ),
        (
          path: 'AppColors.Text.OnContainer.tertiary',
          color: AppColors.Text.OnContainer.tertiary,
        ),
        (
          path: 'AppColors.Text.OnContainer.error',
          color: AppColors.Text.OnContainer.error,
        ),
        (
          path: 'AppColors.Text.OnContainer.success',
          color: AppColors.Text.OnContainer.success,
        ),
        (
          path: 'AppColors.Text.OnContainer.warning',
          color: AppColors.Text.OnContainer.warning,
        ),
        (
          path: 'AppColors.Text.Error.onFill',
          color: AppColors.Text.Error.onFill,
        ),
        (
          path: 'AppColors.Text.Error.onContainer',
          color: AppColors.Text.Error.onContainer,
        ),
        (
          path: 'AppColors.Text.Success.onFill',
          color: AppColors.Text.Success.onFill,
        ),
        (
          path: 'AppColors.Text.Success.onContainer',
          color: AppColors.Text.Success.onContainer,
        ),
        (
          path: 'AppColors.Text.Warning.onFill',
          color: AppColors.Text.Warning.onFill,
        ),
        (
          path: 'AppColors.Text.Warning.onContainer',
          color: AppColors.Text.Warning.onContainer,
        ),
      ];

  static String _hex(Color color) {
    int ch(double x) => (x * 255.0).round().clamp(0, 255);
    final a = ch(color.a);
    final r = ch(color.r);
    final g = ch(color.g);
    final b = ch(color.b);
    final rgb =
        '${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'
            .toUpperCase();
    if (a == 255) return '#$rgb';
    return '#${a.toRadixString(16).padLeft(2, '0')}$rgb'.toUpperCase();
  }

  static Color _labelColor(BuildContext context, Color swatch) {
    final surface = Theme.of(context).colorScheme.surface;
    final blended = Color.alphaBlend(swatch, surface);
    final lum = blended.computeLuminance();
    return lum > 0.5 ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }

  @override
  Widget build(BuildContext context) {
    final entries = _entries();
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacings.m),
      itemBuilder: (context, index) {
        final e = entries[index];
        final fg = _labelColor(context, e.color);
        return DecoratedBox(
          decoration: BoxDecoration(
            color: e.color,
            borderRadius: BorderRadius.circular(AppRadius.m),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacings.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SelectableText(
                  e.path,
                  style: body2Medium.copyWith(color: fg, height: 1.35),
                ),
                const SizedBox(height: AppSpacings.s),
                SelectableText(
                  _hex(e.color),
                  style: labelM.copyWith(color: fg),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
