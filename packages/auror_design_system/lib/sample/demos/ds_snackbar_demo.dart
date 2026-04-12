import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/organisms/feedback/ds_snackbar.dart';
import 'package:flutter/material.dart';

/// Showcases [showSnackbar] for all semantic states (anchored at the top).
class SnackbarDemo extends StatelessWidget {
  const SnackbarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Snackbars appear at the top of the screen. They use semantic container '
          'colors and optional leading icons (set showIcon to false to hide).',
          style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacings.xl2),
        PrimaryButton(
          label: 'Success snackbar',
          brand: ButtonBrand.primary,
          isExpanded: true,
          action: () => showSnackbar(
            context,
            message: 'Saved successfully.',
            state: DsSnackbarState.success,
            hasCloseButton: true,
          ),
        ),
        const SizedBox(height: AppSpacings.m),
        PrimaryButton(
          label: 'Warning snackbar',
          brand: ButtonBrand.secondary,
          isExpanded: true,
          action: () => showSnackbar(
            context,
            message: 'Your session will expire soon.',
            state: DsSnackbarState.warning,
            hasCloseButton: true,
          ),
        ),
        const SizedBox(height: AppSpacings.m),
        PrimaryButton(
          label: 'Neutral snackbar',
          brand: ButtonBrand.tertiary,
          isExpanded: true,
          action: () => showSnackbar(
            context,
            message: 'Tip: you can swipe cards to skip.',
            state: DsSnackbarState.neutral,
            hasCloseButton: true,
          ),
        ),
        const SizedBox(height: AppSpacings.m),
        PrimaryButton(
          label: 'Error snackbar',
          brand: ButtonBrand.primary,
          isExpanded: true,
          action: () => showSnackbar(
            context,
            message: 'Could not sync. Check your connection.',
            state: DsSnackbarState.error,
            hasCloseButton: true,
          ),
        ),
      ],
    );
  }
}
