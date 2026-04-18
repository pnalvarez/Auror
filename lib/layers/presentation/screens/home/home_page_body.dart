import 'package:auror/common/strings/home_strings.dart';
import 'package:auror/layers/presentation/screens/home/home_state.dart';
import 'package:auror/layers/presentation/screens/home/revision_ui.dart';
import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/badges/badge.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:flutter/material.dart';

/// Home tab layout driven by [HomeState]. Used by [HomePage] and Widgetbook.
class HomePageBody extends StatelessWidget {
  const HomePageBody({
    super.key,
    required this.state,
    required this.onSeeMoreRevisions,
  });

  final HomeState state;
  final VoidCallback onSeeMoreRevisions;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacings.xl2),
          child: Builder(
            builder: (context) {
              if (state.isLoading) {
                return Center(child: CircularLoader(color: scheme.primary));
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HomeHeader(
                      userName: state.userName ?? '',
                      totalRevisionTime: state.totalRevisionTime ?? 0,
                      totalTimeToLearnDailyIdea:
                          state.totalTimeToLearnDailyIdea ?? 0,
                    ),
                    const SizedBox(height: AppSpacings.xl3),
                    _SectionHeader(
                      title: homeSectionPendingRevisions,
                      icon: Icons.psychology_rounded,
                      badgeText: state.revisions.length.toString(),
                    ),
                    const SizedBox(height: AppSpacings.l),
                    _HomeRevisionSection(
                      state.revisions,
                      state.tomorrowRevisions ?? 0,
                      onSeeMoreRevisions: onSeeMoreRevisions,
                    ),
                    const SizedBox(height: AppSpacings.xl3),
                    const _SectionHeader(
                      title: homeSectionNewIdeas,
                      icon: Icons.info_outline,
                    ),
                    const SizedBox(height: AppSpacings.l),
                    ListItem(
                      input: TitleDescriptionCTAProgressInput(
                        title: homeDailyIdeaTitle,
                        description: homeDailyIdeaDescription(
                          state.dailyIdea?.cards ?? 0,
                        ),
                        ctaText: homeDailyIdeaCta,
                        onCtaTap: () {},
                        currentProgress:
                            state.dailyIdea?.progress ?? 0,
                        totalProgress: state.dailyIdea?.total ?? 0,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.userName,
    required this.totalRevisionTime,
    required this.totalTimeToLearnDailyIdea,
  });

  final String userName;
  final int totalRevisionTime;
  final int totalTimeToLearnDailyIdea;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(homeGreeting(userName), style: headingH3),
        const SizedBox(height: AppSpacings.s),
        Text.rich(
          TextSpan(
            style: body4Light,
            children: [
              const TextSpan(text: homeHeaderTodayYouHave),
              TextSpan(
                text: homeHeaderMinutes(totalRevisionTime),
                style: body4Semibold,
              ),
              const TextSpan(text: homeHeaderRevisionConnector),
              TextSpan(
                text: homeHeaderMinutes(totalTimeToLearnDailyIdea),
                style: body4Semibold,
              ),
              const TextSpan(text: homeHeaderDailyIdeaSuffix),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
    this.badgeText,
  });

  final IconData icon;
  final String title;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: 24),
        const SizedBox(width: AppSpacings.s),
        Text(title, style: headingH5),
        const Spacer(),
        if (badgeText != null)
          DsBadge(label: badgeText!, variant: BadgeVariant.highlight),
      ],
    );
  }
}

class _HomeRevisionSection extends StatelessWidget {
  const _HomeRevisionSection(
    this.revisions,
    this.tomorrowRevisionsCount, {
    required this.onSeeMoreRevisions,
  });

  final List<RevisionUi> revisions;
  final int tomorrowRevisionsCount;
  final VoidCallback onSeeMoreRevisions;

  @override
  Widget build(BuildContext context) {
    final maxRevisionCount = revisions.length > 3 ? 3 : revisions.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListItem(
          input: GenericListItemInput(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < maxRevisionCount; i++) ...[
                  if (i > 0) const SizedBox(height: AppSpacings.l),
                  _RevisionCard(revision: revisions[i]),
                ],
                const SizedBox(height: AppSpacings.s),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TertiaryButton(
                    label: seeMore,
                    trailingIcon: Icons.add,
                    action: onSeeMoreRevisions,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacings.s),
        Text(
          tomorrowRevisions(tomorrowRevisionsCount),
          style: tagRegular.copyWith(color: AppColors.Surface.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _RevisionCard extends StatelessWidget {
  const _RevisionCard({required this.revision});

  final RevisionUi revision;

  static const double _leadingSize = 40;
  static const double _leadingIconSize = 24;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final titleStyle = body4Semibold.copyWith(
      color: scheme.onSurface,
      height: 1.2,
    );
    final descriptionStyle = body4Light.copyWith(
      color: scheme.onSurfaceVariant,
      height: 1.25,
    );
    final desc = revision.time;

    return ListItem(
      isExpanded: true,
      input: GenericListItemInput(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _leadingSize,
              height: _leadingSize,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.s),
                border: Border.all(
                  color: scheme.outline.withValues(alpha: 0.35),
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.psychology_rounded,
                size: _leadingIconSize,
                color: AppColors.DarkContent.accent,
              ),
            ),
            const SizedBox(width: AppSpacings.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    revision.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: titleStyle,
                  ),
                  const SizedBox(height: AppSpacings.xs),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.access_time,
                          size: 16,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: AppSpacings.xs),
                      Expanded(
                        child: Text(
                          desc,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: descriptionStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
