import 'package:auror/common/strings/onboarding_learning_loop_strings.dart';
import 'package:auror/common/strings/onboarding_real_example_strings.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/molecules/cards/recall_card.dart';
import 'package:auror_design_system/molecules/chips/status_chip.dart';
import 'package:flutter/material.dart';

/// Interactive recall demo for [OnboardingRealExamplePage].
class OnboardingRealExampleBody extends StatelessWidget {
  const OnboardingRealExampleBody({
    super.key,
    required this.recallCardRevealed,
    required this.onReveal,
    required this.onNext,
    required this.onTapError,
    required this.onTapWarning,
    required this.onTapSuccess,
  });

  final bool recallCardRevealed;
  final VoidCallback onReveal;
  final VoidCallback onNext;
  final VoidCallback onTapError;
  final VoidCallback onTapWarning;
  final VoidCallback onTapSuccess;

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
                      onboardingRealExampleTitle,
                      style: headlineS.copyWith(
                        color: scheme.onSurface,
                        height: 1.28,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacings.m),
                    Text(
                      onboardingRealExampleSubtitle,
                      style: body2Light.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacings.xl2),
                    RecallCard(
                      topic: recallTopicCard,
                      title: recallQuestionActiveRecall,
                      description: recallInstructionMental,
                      expectedAnswer: recallExpectedAnswerBody,
                      initialRevealed: false,
                      topicChipState: StatusChipState.primary,
                      onReveal: onReveal,
                      onTapError: onTapError,
                      onTapWarning: onTapWarning,
                      onTapSuccess: onTapSuccess,
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
                enabled: recallCardRevealed,
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
