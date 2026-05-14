import 'package:auror/common/strings/main_launch_strings.dart';
import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/molecules/chips/status_chip.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:flutter/material.dart';

/// Loading state for [MainLaunchPage] (no ViewModel reads — safe for widget tests).
class MainLaunchLoadingBody extends StatelessWidget {
  const MainLaunchLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularLoader(
        color: AppColors.Inverse.inversePrimary,
        size: 40,
        strokeWidth: 3,
      ),
    );
  }
}

/// Ready-state content for [MainLaunchPage]. All navigation / bloc side effects
/// are passed as callbacks so tests can pump this widget with stubs only.
class MainLaunchReadyBody extends StatelessWidget {
  const MainLaunchReadyBody({
    super.key,
    required this.hasActiveSession,
    required this.showDesignSystemCatalog,
    required this.onEnterApp,
    required this.onHowItWorks,
    required this.onOpenDesignSystem,
  });

  final bool hasActiveSession;
  final bool showDesignSystemCatalog;
  final VoidCallback onEnterApp;
  final VoidCallback onHowItWorks;
  final VoidCallback onOpenDesignSystem;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = AppColors.Inverse.inversePrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacings.xl),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSpacings.xl2),
                      Center(
                        child: StatusChip(
                          label: badgePill,
                          state: StatusChipState.neutral,
                        ),
                      ),
                      const SizedBox(height: AppSpacings.xl3),
                      Text.rich(
                        TextSpan(
                          style: headlineM.copyWith(
                            color: scheme.onSurface,
                            height: 1.2,
                          ),
                          children: [
                            const TextSpan(text: heroHeadlineFirst),
                            TextSpan(
                              text: heroHeadlineAccent,
                              style: headlineM.copyWith(
                                color: accent,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacings.xl),
                      Text(
                        heroSubcopy,
                        style: body2Light.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.45,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacings.xl3),
                      const _LaunchFeatureRow(
                        icon: Icons.schedule_rounded,
                        text: featureSessions,
                      ),
                      const SizedBox(height: AppSpacings.l),
                      const _LaunchFeatureRow(
                        icon: Icons.psychology_rounded,
                        text: featureRecall,
                      ),
                      const SizedBox(height: AppSpacings.l),
                      const _LaunchFeatureRow(
                        icon: Icons.event_available_rounded,
                        text: featureReviews,
                      ),
                      const SizedBox(height: AppSpacings.xl3),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacings.xl,
            0,
            AppSpacings.xl,
            AppSpacings.xl3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: hasActiveSession ? ctaContinueStudying : ctaEnterApp,
                  brand: ButtonBrand.primary,
                  action: onEnterApp,
                ),
              ),
              const SizedBox(height: AppSpacings.m),
              Center(
                child: TertiaryButton(
                  label: ctaHowItWorks,
                  brand: ButtonBrand.primary,
                  action: onHowItWorks,
                ),
              ),
              if (showDesignSystemCatalog) ...[
                const SizedBox(height: AppSpacings.l),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    label: ctaDesignSystem,
                    brand: ButtonBrand.tertiary,
                    action: onOpenDesignSystem,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _LaunchFeatureRow extends StatelessWidget {
  const _LaunchFeatureRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
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
          child: Padding(
            padding: const EdgeInsets.all(AppSpacings.s),
            child: Icon(
              icon,
              size: 22,
              color: AppColors.Inverse.inversePrimary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacings.m),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacings.xs),
            child: Text(
              text,
              style: body2Light.copyWith(color: scheme.onSurface, height: 1.35),
            ),
          ),
        ),
      ],
    );
  }
}
