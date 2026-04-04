import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/buttons/button_brand.dart';
import 'package:auror/common/designsystem/organisms/feedback/circular_loader.dart';
import 'package:flutter/material.dart';

const double _kButtonDisabledOpacity = 0.5;
const double _kPrimaryElevation = 2;

/// Filled brand button with elevation (Material shadow).
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.action,
    this.brand = ButtonBrand.primary,
    this.enabled = true,
    this.loading = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String label;
  final VoidCallback action;
  final ButtonBrand brand;
  final bool enabled;
  final bool loading;
  final bool isExpanded;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  static const double _radius = AppRadius.l;

  @override
  Widget build(BuildContext context) {
    final colors = enabled
        ? BrandButtonColors.of(brand)
        : BrandButtonColors.of(brand).disabled();

    final button = Material(
      color: colors.fill,
      elevation: enabled ? _kPrimaryElevation : 0,
      shadowColor: AppColors.Elevation.shadow.withValues(alpha: 0.22),
      borderRadius: BorderRadius.circular(_radius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: (enabled && !loading) ? action : null,
        borderRadius: BorderRadius.circular(_radius),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacings.xl,
            vertical: AppSpacings.m,
          ),
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: loading
                ? CircularLoader(color: colors.onFill)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leadingIcon != null) ...[
                        Icon(leadingIcon, size: 18, color: colors.onFill),
                        const SizedBox(width: AppSpacings.xs),
                      ],
                      Text(
                        label,
                        style: body4Semibold.copyWith(color: colors.onFill),
                        textAlign: TextAlign.center,
                      ),
                      if (trailingIcon != null) ...[
                        const SizedBox(width: AppSpacings.xs),
                        Icon(trailingIcon, size: 18, color: colors.onFill),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );

    Widget result = button;
    if (!enabled && !loading) {
      result = Opacity(opacity: _kButtonDisabledOpacity, child: button);
    }
    if (isExpanded) {
      return SizedBox(width: double.infinity, child: result);
    }
    return result;
  }
}

/// Outlined brand button (transparent fill, brand border and label).
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.action,
    this.brand = ButtonBrand.primary,
    this.enabled = true,
    this.loading = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String label;
  final VoidCallback action;
  final ButtonBrand brand;
  final bool enabled;
  final bool loading;
  final bool isExpanded;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  static const double _radius = AppRadius.l;

  @override
  Widget build(BuildContext context) {
    final colors = enabled
        ? BrandButtonColors.of(brand)
        : BrandButtonColors.of(brand).disabled();

    final button = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_radius),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          border: Border.all(color: colors.fill, width: 1.5),
        ),
        child: InkWell(
          onTap: (enabled && !loading) ? action : null,
          borderRadius: BorderRadius.circular(_radius),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacings.xl,
              vertical: AppSpacings.m,
            ),
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: loading
                  ? CircularLoader(color: colors.fill)
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (leadingIcon != null) ...[
                          Icon(leadingIcon, size: 18, color: colors.fill),
                          const SizedBox(width: AppSpacings.xs),
                        ],
                        Text(
                          label,
                          style: body4Semibold.copyWith(color: colors.fill),
                          textAlign: TextAlign.center,
                        ),
                        if (trailingIcon != null) ...[
                          const SizedBox(width: AppSpacings.xs),
                          Icon(trailingIcon, size: 18, color: colors.fill),
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ),
    );

    Widget result = button;
    if (!enabled && !loading) {
      result = Opacity(opacity: _kButtonDisabledOpacity, child: button);
    }
    if (isExpanded) {
      return SizedBox(width: double.infinity, child: result);
    }
    return result;
  }
}

/// Text-only action with ink splash / highlight for press feedback.
class TertiaryButton extends StatelessWidget {
  const TertiaryButton({
    super.key,
    required this.label,
    required this.action,
    this.brand = ButtonBrand.primary,
    this.enabled = true,
    this.loading = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String label;
  final VoidCallback action;
  final ButtonBrand brand;
  final bool enabled;
  final bool loading;
  final bool isExpanded;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final colors = enabled
        ? BrandButtonColors.of(brand)
        : BrandButtonColors.of(brand).disabled();

    final splash = colors.fill.withValues(alpha: 0.12);
    final highlight = colors.fill.withValues(alpha: 0.08);

    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (enabled && !loading) ? action : null,
        borderRadius: BorderRadius.circular(AppRadius.s),
        splashColor: splash,
        highlightColor: highlight,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacings.s,
            vertical: AppSpacings.xs,
          ),
          child: loading
              ? Center(child: CircularLoader(color: colors.fill))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (leadingIcon != null) ...[
                      Icon(leadingIcon, size: 18, color: colors.fill),
                      const SizedBox(width: AppSpacings.xs),
                    ],
                    Text(
                      label,
                      style: body4Semibold.copyWith(color: colors.fill),
                      textAlign: TextAlign.center,
                    ),
                    if (trailingIcon != null) ...[
                      const SizedBox(width: AppSpacings.xs),
                      Icon(trailingIcon, size: 18, color: colors.fill),
                    ],
                  ],
                ),
        ),
      ),
    );

    Widget result = button;
    if (!enabled && !loading) {
      result = Opacity(opacity: _kButtonDisabledOpacity, child: button);
    }
    if (isExpanded) {
      return SizedBox(width: double.infinity, child: result);
    }
    return result;
  }
}
