import 'package:auror/common/designsystem/molecules/feedback/ds_snackbar.dart';
import 'package:auror/common/strings.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_event.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_state.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/designsystem/molecules/buttons/button_brand.dart';
import 'package:auror/common/designsystem/molecules/cards/recall_card.dart';
import 'package:auror/common/designsystem/molecules/chips/status_chip.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef _BlocBuilder =
    BlocBuilder<OnboardingRealExampleViewModel, OnboardingRealExampleState>;

@RoutePage()
class OnboardingRealExamplePage extends StatelessWidget {
  const OnboardingRealExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OnboardingRealExampleViewModel()..add(OnboardingRealExampleStarted()),
      child: Theme(
        data: mainLaunchDarkTheme(),
        child: const _OnboardingRealExampleContent(),
      ),
    );
  }
}

class _OnboardingRealExampleContent extends StatelessWidget {
  const _OnboardingRealExampleContent();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final viewModel = context.read<OnboardingRealExampleViewModel>();

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
                      onReveal: () => viewModel.add(
                        OnboardingRealExampleEvent.recallCardRevealed(),
                      ),
                      onTapError: () => showSnackbar(
                        context,
                        message: errorFeedback,
                        state: .error,
                        hasCloseButton: true,
                      ),
                      onTapWarning: () => showSnackbar(
                        context,
                        message: warningFeedback,
                        state: .warning,
                        hasCloseButton: true,
                      ),
                      onTapSuccess: () => showSnackbar(
                        context,
                        message: successFeedback,
                        state: .success,
                        hasCloseButton: true,
                      ),
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
              child: _BlocBuilder(
                builder: (_, state) {
                  return PrimaryButton(
                    label: ctaNext,
                    enabled: state.recallCardRevealed,
                    brand: ButtonBrand.primary,
                    action: () => context.router.push(
                      const OnboardingGuidedRoutesRoute(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
