import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:auror/common/strings/revision_quiz_strings.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Shown after the last revision’s “Finalizar” confirmation; summarizes the session
/// and returns the user to [DashboardHomeRoute] via the bottom tab bar.
@RoutePage()
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key, required this.revisionCount});

  final int revisionCount;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacings.xl2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _SuccessMark(),
                const SizedBox(height: AppSpacings.xl2),
                Text(
                  revisionQuizEndTitle,
                  textAlign: TextAlign.center,
                  style: headlineS.copyWith(
                    color: AppColors.Inverse.onInverseSurface,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: AppSpacings.xl),
                Text.rich(
                  TextSpan(
                    style: body2Light.copyWith(
                      color: AppColors.Text.Inverse.secondary,
                      height: 1.45,
                    ),
                    children: [
                      const TextSpan(text: revisionQuizEndBodyPrefix),
                      TextSpan(
                        text: '$revisionCount',
                        style: body2Semibold.copyWith(
                          color: AppColors.Inverse.onInverseSurface,
                        ),
                      ),
                      const TextSpan(text: revisionQuizEndBodySuffix),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacings.xl3),
                PrimaryButton(
                  label: revisionQuizEndBackToToday,
                  action: () => _popQuizAndSelectHome(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _popQuizAndSelectHome(BuildContext context) {
    context.router.root.navigate(
      const DashboardRoute(children: [DashboardHomeRoute()]),
    );
  }
}

class _SuccessMark extends StatelessWidget {
  const _SuccessMark();

  @override
  Widget build(BuildContext context) {
    final fill = AppColors.Success.success;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: fill.withValues(alpha: 0.45),
                blurRadius: 36,
                spreadRadius: 4,
              ),
            ],
          ),
        ),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: fill,
            boxShadow: [
              BoxShadow(
                color: fill.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.check_rounded,
            color: AppColors.Success.onSuccess,
            size: 40,
          ),
        ),
      ],
    );
  }
}
