import 'package:auror/common/environment/app_environment.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auror/common/strings/main_launch_strings.dart';
import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/designsystem/molecules/buttons/button_brand.dart';
import 'package:auror/common/designsystem/molecules/chips/status_chip.dart';
import 'package:auror/common/designsystem/molecules/feedback/circular_loader.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_event.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_state.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainLaunchPage extends StatelessWidget {
  const MainLaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          MainLaunchViewModel()..add(const MainLaunchEvent.started()),
      child: Theme(data: mainLaunchDarkTheme(), child: const _MainLaunchView()),
    );
  }
}

class _MainLaunchView extends StatelessWidget {
  const _MainLaunchView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: BlocBuilder<MainLaunchViewModel, MainLaunchState>(
          builder: (context, state) {
            return state.when(
              initial: () => const _LaunchLoadingBody(),
              loading: () => const _LaunchLoadingBody(),
              ready: (hasActiveSession) =>
                  _LaunchContentBody(hasActiveSession: hasActiveSession),
            );
          },
        ),
      ),
    );
  }
}

class _LaunchLoadingBody extends StatelessWidget {
  const _LaunchLoadingBody();

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

class _LaunchContentBody extends StatelessWidget {
  const _LaunchContentBody({required this.hasActiveSession});

  final bool hasActiveSession;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = AppColors.Inverse.inversePrimary;

    return LayoutBuilder(
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
                        style: headlineM.copyWith(color: accent, height: 1.2),
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
                const SizedBox(height: AppSpacings.xl4),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    label: hasActiveSession ? ctaContinueStudying : ctaEnterApp,
                    brand: ButtonBrand.primary,
                    action: () => context.read<MainLaunchViewModel>().add(
                      const MainLaunchEvent.enterAppTapped(),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                Center(
                  child: TertiaryButton(
                    label: ctaHowItWorks,
                    brand: ButtonBrand.primary,
                    action: () =>
                        context.router.push(OnboardingLearningLoopRoute()),
                  ),
                ),
                if (AppEnvironment.showDesignSystemCatalog) ...[
                  const SizedBox(height: AppSpacings.l),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: ctaDesignSystem,
                      brand: .tertiary,
                      action: () =>
                          context.router.push(const DsMenuSampleRoute()),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacings.xl3),
              ],
            ),
          ),
        );
      },
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
