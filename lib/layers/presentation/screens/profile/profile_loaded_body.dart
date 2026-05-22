import 'package:auror/common/strings/profile_strings.dart';
import 'package:auror/layers/presentation/screens/profile/profile_ui.dart';
import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/molecules/cards/score_tile.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/organisms/profile/profile_header.dart';
import 'package:flutter/material.dart';

/// Loaded profile tab for [ProfilePage] (no Bloc / router).
class ProfileLoadedBody extends StatelessWidget {
  const ProfileLoadedBody({
    super.key,
    required this.profile,
    required this.logoutLoading,
    required this.onPlanRowTap,
    required this.onMyRoutesTap,
    required this.onLogoutTap,
  });

  final ProfileUI profile;
  final bool logoutLoading;
  final VoidCallback onPlanRowTap;
  final VoidCallback onMyRoutesTap;
  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.DarkContent.accent;

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
                    title: profile.subscriptionPlan,
                    description: profile.hasUpgrade ? upgrade : null,
                  ),
                  onTap: onPlanRowTap,
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
                  onTap: onMyRoutesTap,
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
              loading: logoutLoading,
              action: onLogoutTap,
            ),
          ),
        ),
      ],
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
