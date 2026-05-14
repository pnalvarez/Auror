import 'package:auror/common/strings/onboarding_learning_loop_strings.dart'
    show ctaNext;
import 'package:auror/common/strings/onboarding_learning_section_strings.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/molecules/cards/disclaimer_card.dart';
import 'package:flutter/material.dart';

/// Three-step disclaimer + quote for [OnboardingLearningSectionPage].
class OnboardingLearningSectionBody extends StatelessWidget {
  const OnboardingLearningSectionBody({super.key, required this.onNext});

  final VoidCallback onNext;

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
                      onboardingSectionTitle,
                      style: headlineS.copyWith(
                        color: scheme.onSurface,
                        height: 1.28,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacings.m),
                    Text(
                      onboardingSectionSubtitle,
                      style: body2Light.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacings.xl3),
                    const DisclaimerCard(
                      step: 1,
                      title: disclaimerStep1Title,
                      description: disclaimerStep1Description,
                    ),
                    const SizedBox(height: AppSpacings.xl2),
                    const DisclaimerCard(
                      step: 2,
                      title: disclaimerStep2Title,
                      description: disclaimerStep2Description,
                    ),
                    const SizedBox(height: AppSpacings.xl2),
                    const DisclaimerCard(
                      step: 3,
                      title: disclaimerStep3Title,
                      description: disclaimerStep3Description,
                    ),
                    const SizedBox(height: AppSpacings.xl3),
                    Text(
                      onboardingSectionQuote,
                      style: body2Light.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.45,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
                action: onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
