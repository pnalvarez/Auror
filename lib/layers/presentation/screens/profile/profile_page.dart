import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/molecules/cards/score_tile.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/organisms/profile/profile_header.dart';
import 'package:auror/common/strings/profile_strings.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/profile/profile_event.dart';
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
      create: (_) =>
          getIt<ProfileViewModel>()..add(const ProfileEvent.loadRequested()),
      child: const _ProfileScaffold(),
    );
  }
}

class _ProfileScaffold extends StatelessWidget {
  const _ProfileScaffold();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = AppColors.DarkContent.accent;

    return SafeArea(
      bottom: false,
      child: BlocBuilder<ProfileViewModel, ProfileState>(
        builder: (context, state) {
          if (state.isLoading && state.profile == null) {
            return Center(
              child: CircularProgressIndicator(color: scheme.primary),
            );
          }
          if (state.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacings.xl2),
                child: Text(
                  profileLoadErrorMessage,
                  textAlign: TextAlign.center,
                  style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
            );
          }

          final profile = state.profile;
          if (profile == null) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacings.xl2,
                    AppSpacings.xl4,
                    AppSpacings.xl2,
                    AppSpacings.m,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProfileHeader(
                        imageUrl: profile.profileImageUrl,
                        name: profile.username,
                        email: profile.email,
                        avatarRingColor: accent,
                        emailIconColor: accent,
                      ),
                      const SizedBox(height: AppSpacings.xl2),
                      Row(
                        children: [
                          Expanded(
                            child: ScoreTile(
                              icon: Icons.menu_book_outlined,
                              score: profile.learnedCards,
                              label: profileStatLearnedCards,
                              iconColor: accent,
                            ),
                          ),
                          const SizedBox(width: AppSpacings.m),
                          Expanded(
                            child: ScoreTile(
                              icon: Icons.psychology_outlined,
                              score: profile.revisionsDone,
                              label: profileStatRevisionsDone,
                              iconColor: accent,
                            ),
                          ),
                          const SizedBox(width: AppSpacings.m),
                          Expanded(
                            child: ScoreTile(
                              icon: Icons.local_fire_department_outlined,
                              score: profile.followedDays,
                              label: profileStatFollowedDays,
                              iconColor: accent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacings.xl2),
                      _SectionLabel(text: profileSectionPlan),
                      const SizedBox(height: AppSpacings.m),
                      ListItem(
                        isExpanded: true,
                        input: IconTitleDescriptionInput(
                          leadingIcon: Icons.workspace_premium_outlined,
                          title: profile.isSubscribed
                              ? profilePlanSubscribedTitle
                              : profilePlanFreeTitle,
                          description: profile.isSubscribed
                              ? profilePlanSubscribedDescription
                              : profilePlanFreeDescription,
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(height: AppSpacings.xl2),
                      _SectionLabel(text: profileSectionNavigation),
                      const SizedBox(height: AppSpacings.m),
                      ListItem(
                        isExpanded: true,
                        input: IconDescriptionInput(
                          leadingIcon: Icons.route_outlined,
                          title: profileNavMyRoutes,
                        ),
                        onTap: () {
                          context.tabsRouter.setActiveIndex(3);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacings.xl2,
                    AppSpacings.xl2,
                    AppSpacings.xl2,
                    AppSpacings.m,
                  ),
                  child: SecondaryButton(
                    label: profileLogoutLabel,
                    brand: ButtonBrand.error,
                    leadingIcon: Icons.logout_rounded,
                    isExpanded: true,
                    action: () {
                      context.router.replace(MainLaunchRoute());
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Text(
      text,
      style: labelS.copyWith(
        color: scheme.onSurfaceVariant,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }
}
