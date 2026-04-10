import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/strings/revision_quiz_strings.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Celebration when the user finishes their first revision (single-item quiz list).
Future<void> showFirstRevisionCompletedDialog(
  BuildContext context, {
  required VoidCallback onContinueToHome,
}) {
  final accent = AppColors.Primary.primary;
  final well = AppColors.DarkContent.iconWell;
  final onSurface = AppColors.Inverse.onInverseSurface;
  final muted = AppColors.Text.Inverse.secondary;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.Elevation.scrim.withValues(alpha: 0.55),
    builder: (ctx) {
      return Dialog(
        backgroundColor: AppColors.DarkContent.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.l),
          side: BorderSide(color: accent.withValues(alpha: 0.35), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacings.xl5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: well,
                  border: Border.all(color: accent, width: 2),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.celebration_rounded, color: accent, size: 28),
              ),
              const SizedBox(height: AppSpacings.xl),
              Text(
                revisionQuizFirstRevisionTitle,
                textAlign: TextAlign.center,
                style: headlineS.copyWith(color: onSurface, height: 1.2),
              ),
              const SizedBox(height: AppSpacings.xl2),
              Text(
                revisionQuizFirstRevisionBody,
                textAlign: TextAlign.center,
                style: body2Light.copyWith(color: muted, height: 1.45),
              ),
              const SizedBox(height: AppSpacings.xl4),
              PrimaryButton(
                label: revisionQuizEndBackToToday,
                trailingIcon: Icons.chevron_right,
                action: onContinueToHome,
                isExpanded: true,
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// Uses the root [StackRouter]'s navigator so this is safe after the quiz route is popped.
Future<void> showFirstRevisionCompletedDialogForRouter(StackRouter rootRouter) {
  final ctx = rootRouter.navigatorKey.currentContext;
  if (ctx == null) {
    return Future<void>.value();
  }
  return showFirstRevisionCompletedDialog(
    ctx,
    onContinueToHome: () {
      Navigator.of(ctx, rootNavigator: true).pop();
      rootRouter.navigate(
        const DashboardRoute(children: [DashboardHomeRoute()]),
      );
    },
  );
}
