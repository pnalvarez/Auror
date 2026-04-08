import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:flutter/material.dart';

/// Semantic surface for [ListItem]: border, fill, and typography tints.
enum ListItemBrand {
  /// Same shell as default [ListItem]: theme surface + outline; gold leading icon.
  neutral,

  /// Positive / completed — green tones.
  success,

  /// Caution / attention — amber tones.
  warning,

  /// Destructive / error — red tones.
  error,
}

/// Resolved colors for a [ListItemBrand] on the current [ColorScheme].
@immutable
class ListItemBrandStyle {
  const ListItemBrandStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.titleTextColor,
    required this.bodyTextColor,
    required this.leadingIconColor,
    required this.trailingIconColor,
    this.borderWidth = 1,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color titleTextColor;
  final Color bodyTextColor;
  final Color leadingIconColor;
  final Color trailingIconColor;
  final double borderWidth;

  /// Semantic rows use [AppColors.Success] / [Warning] / [Error] for surfaces and
  /// borders; titles and leading icons use each palette’s **main** tone; body and
  /// chevron use [AppColors.Text.OnContainer] for on-container copy.
  static ListItemBrandStyle resolve(ListItemBrand brand, ColorScheme scheme) {
    return switch (brand) {
      ListItemBrand.neutral => ListItemBrandStyle(
        backgroundColor: scheme.surfaceContainerHigh,
        borderColor: scheme.outline.withValues(alpha: 0.35),
        titleTextColor: scheme.onSurface,
        bodyTextColor: scheme.onSurfaceVariant,
        leadingIconColor: scheme.onSurface,
        trailingIconColor: scheme.onSurfaceVariant,
      ),
      ListItemBrand.success => ListItemBrandStyle(
        backgroundColor: AppColors.Success.successContainer,
        borderColor: AppColors.Success.success.withValues(alpha: 0.45),
        titleTextColor: AppColors.Success.success,
        bodyTextColor: AppColors.Text.OnContainer.success,
        leadingIconColor: AppColors.Success.success,
        trailingIconColor: AppColors.Text.OnContainer.success.withValues(
          alpha: 0.92,
        ),
        borderWidth: 2,
      ),
      ListItemBrand.warning => ListItemBrandStyle(
        backgroundColor: AppColors.Warning.warningContainer,
        borderColor: AppColors.Warning.warning.withValues(alpha: 0.45),
        titleTextColor: AppColors.Warning.warning,
        bodyTextColor: AppColors.Text.OnContainer.warning,
        leadingIconColor: AppColors.Warning.warning,
        trailingIconColor: AppColors.Text.OnContainer.warning.withValues(
          alpha: 0.92,
        ),
        borderWidth: 2,
      ),
      ListItemBrand.error => ListItemBrandStyle(
        backgroundColor: AppColors.Error.errorContainer,
        borderColor: AppColors.Error.error.withValues(alpha: 0.45),
        titleTextColor: AppColors.Error.error,
        bodyTextColor: AppColors.Text.OnContainer.error,
        leadingIconColor: AppColors.Error.error,
        trailingIconColor: AppColors.Text.OnContainer.error.withValues(
          alpha: 0.92,
        ),
        borderWidth: 2,
      ),
    };
  }
}

/// Provides [ListItemBrandStyle] to [ListItem] content (title/body/icon colors).
class ListItemBrandScope extends InheritedWidget {
  const ListItemBrandScope({
    super.key,
    required this.style,
    required super.child,
  });

  final ListItemBrandStyle style;

  /// Resolves [ListItemBrandStyle] from an ancestor scope. Callers must use a
  /// [BuildContext] **below** [ListItem]’s [ListItemBrandScope] (see [ListItem]
  /// implementation); otherwise this falls back to [ListItemBrand.neutral].
  static ListItemBrandStyle of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<ListItemBrandScope>();
    if (scope != null) {
      return scope.style;
    }
    final scheme = Theme.of(context).colorScheme;
    return ListItemBrandStyle.resolve(ListItemBrand.neutral, scheme);
  }

  @override
  bool updateShouldNotify(ListItemBrandScope oldWidget) =>
      style != oldWidget.style;
}
