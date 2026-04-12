import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Semantic tone for [showSnackbar].
enum DsSnackbarState { success, warning, neutral, error }

OverlayEntry? _activeDsSnackbarEntry;

/// Shows a design-system snackbar anchored to the **top** of the screen (overlay),
/// using semantic container colors and optional leading icons.
void showSnackbar(
  BuildContext context, {
  required String message,
  required DsSnackbarState state,
  bool showIcon = true,
  bool hasCloseButton = false,
  Duration duration = const Duration(seconds: 4),
}) {
  final overlayState =
      Overlay.maybeOf(context) ?? Navigator.maybeOf(context)?.overlay;
  if (overlayState == null) {
    return;
  }

  _activeDsSnackbarEntry?.remove();
  _activeDsSnackbarEntry = null;

  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (ctx) => Positioned(
      left: AppSpacings.l,
      right: AppSpacings.l,
      top: 0,
      child: SafeArea(
        bottom: false,
        maintainBottomViewPadding: true,
        child: Semantics(
          liveRegion: true,
          child: _DsSnackbarBody(
            message: message,
            state: state,
            showIcon: showIcon,
            hasCloseButton: hasCloseButton,
          ),
        ),
      ),
    ),
  );

  _activeDsSnackbarEntry = entry;
  overlayState.insert(entry);

  Future<void>.delayed(duration, () {
    if (_activeDsSnackbarEntry == entry) {
      entry.remove();
      _activeDsSnackbarEntry = null;
    }
  });
}

class _DsSnackbarBody extends StatelessWidget {
  const _DsSnackbarBody({
    required this.message,
    required this.state,
    required this.showIcon,
    required this.hasCloseButton,
  });

  final String message;
  final DsSnackbarState state;
  final bool showIcon;
  final bool hasCloseButton;

  (Color background, Color foreground, IconData defaultIcon) _tokens() {
    return switch (state) {
      DsSnackbarState.success => (
        AppColors.Success.successContainer,
        AppColors.Success.onSuccessContainer,
        Icons.check_circle_rounded,
      ),
      DsSnackbarState.warning => (
        AppColors.Warning.warningContainer,
        AppColors.Warning.onWarningContainer,
        Icons.warning_amber_rounded,
      ),
      DsSnackbarState.neutral => (
        AppColors.Surface.surfaceContainerHigh,
        AppColors.Surface.onSurfaceVariant,
        Icons.info_outline_rounded,
      ),
      DsSnackbarState.error => (
        AppColors.Error.errorContainer,
        AppColors.Error.onErrorContainer,
        Icons.error_outline_rounded,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final (background, foreground, defaultIcon) = _tokens();
    return Material(
      color: background,
      elevation: 2,
      shadowColor: AppColors.Elevation.shadow.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(AppRadius.m),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.l,
          vertical: AppSpacings.m,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showIcon) ...[
              Icon(defaultIcon, color: foreground, size: 16),
              const SizedBox(width: AppSpacings.s),
            ],
            Expanded(
              child: Text(
                message,
                style: body4Medium.copyWith(color: foreground, height: 1.35),
              ),
            ),
            if (hasCloseButton) ...[
              const SizedBox(width: AppSpacings.s),
              IconButton(
                onPressed: () {
                  _activeDsSnackbarEntry?.remove();
                  _activeDsSnackbarEntry = null;
                },
                style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  iconSize: 16,
                ),
                icon: Icon(Icons.close_rounded, color: foreground),
                tooltip: 'Close',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
