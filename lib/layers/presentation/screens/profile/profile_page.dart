import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/feedback/ds_snackbar.dart';
import 'package:auror/common/strings/profile_strings.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/profile/profile_event.dart';
import 'package:auror/layers/presentation/screens/profile/profile_loaded_body.dart';
import 'package:auror/layers/presentation/screens/profile/profile_state.dart';
import 'package:auror/layers/presentation/screens/profile/profile_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Profile tab (view model from GetIt only).
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileViewModel>(),
      child: const _ProfileScaffold(),
    );
  }
}

class _ProfileScaffold extends StatefulWidget {
  const _ProfileScaffold();

  @override
  State<_ProfileScaffold> createState() => _ProfileScaffoldState();
}

class _ProfileScaffoldState extends State<_ProfileScaffold>
    with AutoRouteAwareStateMixin<_ProfileScaffold> {
  void _dispatchLoadRequested() {
    context.read<ProfileViewModel>().add(const ProfileEvent.loadRequested());
  }

  @override
  void didInitTabRoute(TabPageRoute? previousRoute) {
    _dispatchLoadRequested();
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {
    _dispatchLoadRequested();
  }

  @override
  void didPopNext() {
    _dispatchLoadRequested();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: BlocListener<ProfileViewModel, ProfileState>(
        listenWhen: (previous, current) =>
            !previous.pendingMainLaunchNavigation &&
            current.pendingMainLaunchNavigation,
        listener: (context, state) {
          context.router.replace(MainLaunchRoute());
          context.read<ProfileViewModel>().add(
            const ProfileEvent.mainLaunchNavigationConsumed(),
          );
        },
        child: BlocListener<ProfileViewModel, ProfileState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage &&
              current.errorMessage != null &&
              current.profile != null,
          listener: (context, state) {
            final message = state.errorMessage;
            if (message == null) return;
            showSnackbar(
              context,
              message: message,
              state: DsSnackbarState.error,
              hasCloseButton: true,
            );
          },
          child: BlocBuilder<ProfileViewModel, ProfileState>(
            builder: (context, state) {
              if (state.isLoadingData && state.profile == null) {
                return Center(
                  child: CircularProgressIndicator(color: scheme.primary),
                );
              }
              if (state.errorMessage != null && state.profile == null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacings.xl2),
                    child: Text(
                      profileLoadErrorMessage,
                      textAlign: TextAlign.center,
                      style: body2Medium.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              }

              final profile = state.profile;
              if (profile == null) {
                return const SizedBox.shrink();
              }

              return ProfileLoadedBody(
                profile: profile,
                logoutLoading: state.pendingLogoutNavigation,
                onPlanRowTap: () async {
                  await context.router.push(
                    const SubscriptionUpgradeRoute(),
                  );
                  if (!context.mounted) return;
                  context.read<ProfileViewModel>().add(
                    const ProfileEvent.loadRequested(),
                  );
                },
                onMyRoutesTap: () {
                  context.tabsRouter.setActiveIndex(3);
                },
                onLogoutTap: () {
                  context.read<ProfileViewModel>().add(
                    const ProfileEvent.logoutTapped(),
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
