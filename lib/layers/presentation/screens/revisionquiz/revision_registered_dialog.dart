import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/strings/revision_quiz_strings.dart';
import 'package:flutter/material.dart';

/// Spaced-repetition schedule chosen on a [FeedbackTile] (D+1 / D+3 / D+7).
enum RevisionFeedbackSchedule {
  nextDay,
  threeDays,
  sevenDays;

  String get intervalPhrase {
    return switch (this) {
      RevisionFeedbackSchedule.nextDay => revisionQuizRegisteredNextIntervalD1,
      RevisionFeedbackSchedule.threeDays =>
        revisionQuizRegisteredNextIntervalD3,
      RevisionFeedbackSchedule.sevenDays =>
        revisionQuizRegisteredNextIntervalD7,
    };
  }
}

/// Dark navy + gold confirmation aligned with [AppColors.DarkContent].
Future<void> showRevisionRegisteredDialog(
  BuildContext context, {
  required String lessonTitle,
  required RevisionFeedbackSchedule schedule,
  required VoidCallback onContinue,
}) {
  final accent = AppColors.Primary.primary;
  final well = AppColors.DarkContent.iconWell;
  final onSurface = AppColors.Inverse.onInverseSurface;
  final muted = AppColors.Text.Inverse.secondary;

  return showDialog<void>(
    context: context,
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
                child: Icon(Icons.check_rounded, color: accent, size: 28),
              ),
              const SizedBox(height: AppSpacings.xl),
              Text(
                revisionQuizRegisteredTitle,
                textAlign: TextAlign.center,
                style: headlineS.copyWith(color: onSurface, height: 1.2),
              ),
              const SizedBox(height: AppSpacings.xl4),
              Text.rich(
                TextSpan(
                  style: body2Light.copyWith(height: 1.45),
                  children: [
                    TextSpan(
                      text: lessonTitle,
                      style: body3Light.copyWith(color: accent),
                    ),
                    TextSpan(
                      text: revisionQuizRegisteredBodyMiddle,
                      style: body3Light.copyWith(color: muted),
                    ),
                    TextSpan(
                      text: schedule.intervalPhrase,
                      style: body3Semibold.copyWith(color: accent),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacings.xl4),
              PrimaryButton(
                label: revisionQuizRegisteredCta,
                trailingIcon: Icons.chevron_right,
                action: onContinue,
                isExpanded: true,
              ),
            ],
          ),
        ),
      );
    },
  );
}
