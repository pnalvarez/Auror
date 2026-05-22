import 'package:auror/common/environment/app_environment.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_body.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_event.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_state.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_view_model.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainLaunchPage extends StatelessWidget {
  const MainLaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<MainLaunchViewModel>()..add(const MainLaunchEvent.started()),
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
        child: BlocListener<MainLaunchViewModel, MainLaunchState>(
          listenWhen: (previous, current) {
            final wasPending = switch (previous) {
              MainLaunchStateReady(:final pendingDashboardNavigation) =>
                pendingDashboardNavigation,
              _ => false,
            };
            final isPending = switch (current) {
              MainLaunchStateReady(:final pendingDashboardNavigation) =>
                pendingDashboardNavigation,
              _ => false,
            };
            return !wasPending && isPending;
          },
          listener: (context, state) {
            context.router.replace(const DashboardRoute());
            context.read<MainLaunchViewModel>().add(
              const MainLaunchEvent.dashboardNavigationConsumed(),
            );
          },
          child: BlocBuilder<MainLaunchViewModel, MainLaunchState>(
            builder: (context, state) {
              return state.when(
                initial: () => const MainLaunchLoadingBody(),
                loading: () => const MainLaunchLoadingBody(),
                ready: (hasActiveSession, pendingDashboardNavigation) {
                  if (pendingDashboardNavigation) {
                    return const MainLaunchLoadingBody();
                  }
                  return MainLaunchReadyBody(
                          hasActiveSession: hasActiveSession,
                          showDesignSystemCatalog:
                              AppEnvironment.showDesignSystemCatalog,
                          onEnterApp: () {
                            context.read<MainLaunchViewModel>().add(
                              const MainLaunchEvent.enterAppTapped(),
                            );
                            if (!hasActiveSession) {
                              context.router.push(
                                LoginRoute(loginContext: LoginContext.signIn),
                              );
                            }
                          },
                          onHowItWorks: () {
                            context.read<MainLaunchViewModel>().add(
                              const MainLaunchEvent.howItWorksTapped(),
                            );
                            context.router.push(
                              OnboardingLearningLoopRoute(),
                            );
                          },
                          onOpenDesignSystem: () => context.router.push(
                            const DsMenuSampleRoute(),
                          ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
