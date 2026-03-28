import 'package:auto_route/auto_route.dart';
import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/designsystem/molecules/buttons/button_brand.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:auror/common/strings/onboarding_learning_loop_strings.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingLearningLoopPage extends StatelessWidget {
  const OnboardingLearningLoopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: const _OnboardingLearningLoopView(),
    );
  }
}

class _OnboardingLearningLoopView extends StatelessWidget {
  const _OnboardingLearningLoopView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacings.xl,
                  AppSpacings.xl2,
                  AppSpacings.xl,
                  AppSpacings.l,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      onboardingHowItWorksTitle,
                      style: subtitle2xs.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.9),
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacings.m),
                    Text(
                      onboardingLoopTitle,
                      style: headlineS.copyWith(
                        color: scheme.onSurface,
                        height: 1.28,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacings.xl2),
                    Text(
                      onboardingStepsLead,
                      style: labelM.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacings.l),
                    const _LoopStepTile(stepNumber: 1),
                    const _LoopStepConnector(),
                    const _LoopStepTile(stepNumber: 2),
                    const _LoopStepConnector(),
                    const _LoopStepTile(stepNumber: 3),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacings.xl,
                AppSpacings.s,
                AppSpacings.xl,
                AppSpacings.xl,
              ),
              child: PrimaryButton(
                label: ctaNext,
                brand: ButtonBrand.primary,
                action: () =>
                    context.router.push(const OnboardingLearningSectionRoute()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoopStepConnector extends StatelessWidget {
  const _LoopStepConnector();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.s),
      child: Center(
        child: Icon(
          Icons.arrow_downward_rounded,
          size: 20,
          color: scheme.primary.withValues(alpha: 0.55),
        ),
      ),
    );
  }
}

class _LoopStepTile extends StatelessWidget {
  const _LoopStepTile({required this.stepNumber});

  final int stepNumber;

  static const double _iconSize = 48;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = AppColors.Inverse.inversePrimary;

    final icon = Icon(
      _iconForStep(stepNumber),
      color: accent,
      size: 26,
    );

    final (top, title, description) = switch (stepNumber) {
      1 => (step1Top, step1Title, step1Description),
      2 => (step2Top, step2Title, step2Description),
      _ => (step3Top, step3Title, step3Description),
    };

    final numberStyle = headline2xs.copyWith(color: accent, height: 1.1);
    final titleStyle = subtitleXs.copyWith(
      color: scheme.onSurface,
      height: 1.25,
    );
    final bodyStyle = body2Light.copyWith(
      color: scheme.onSurfaceVariant,
      height: 1.45,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.l),
        border: Border.all(
          color: AppColors.Primary.primary.withValues(alpha: 0.22),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacings.l),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppRadius.s),
                border: Border.all(
                  color: AppColors.Primary.primary.withValues(alpha: 0.45),
                  width: 1,
                ),
              ),
              child: SizedBox(
                width: _iconSize,
                height: _iconSize,
                child: Center(child: icon),
              ),
            ),
            const SizedBox(width: AppSpacings.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(top, style: numberStyle),
                  const SizedBox(height: AppSpacings.xs),
                  Text(title, style: titleStyle),
                  const SizedBox(height: AppSpacings.s),
                  Text(description, style: bodyStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForStep(int step) {
    return switch (step) {
      1 => Icons.lightbulb_outline_rounded,
      2 => Icons.quiz_outlined,
      _ => Icons.sync_rounded,
    };
  }
}
