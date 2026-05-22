import 'package:auror/common/strings.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_body.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_event.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_state.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auror_design_system/organisms/feedback/ds_snackbar.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
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
          getIt<OnboardingRealExampleViewModel>()
            ..add(const OnboardingRealExampleStarted()),
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
    final viewModel = context.read<OnboardingRealExampleViewModel>();

    return _BlocBuilder(
      builder: (context, state) {
        return OnboardingRealExampleBody(
          recallCardRevealed: state.recallCardRevealed,
          onReveal: () => viewModel.add(
            const OnboardingRealExampleEvent.recallCardRevealed(),
          ),
          onNext: () => context.router.push(
            const OnboardingGuidedRoutesRoute(),
          ),
          onTapError: () => showSnackbar(
            context,
            message: errorFeedback,
            state: DsSnackbarState.error,
            hasCloseButton: true,
          ),
          onTapWarning: () => showSnackbar(
            context,
            message: warningFeedback,
            state: DsSnackbarState.warning,
            hasCloseButton: true,
          ),
          onTapSuccess: () => showSnackbar(
            context,
            message: successFeedback,
            state: DsSnackbarState.success,
            hasCloseButton: true,
          ),
        );
      },
    );
  }
}
