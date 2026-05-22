import 'package:auror/common/strings/revision_hub_strings.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_ui.dart';
import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/badges/badge.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:flutter/material.dart' hide Badge;

/// Today's revisions list + CTA for [RevisionHubPage]. Router calls stay in the page.
class RevisionHubBody extends StatelessWidget {
  const RevisionHubBody({
    super.key,
    required this.isLoading,
    required this.revisions,
    this.errorMessage,
    required this.totalMinutes,
    required this.onStartRevision,
  });

  final bool isLoading;
  final List<RevisionIntroUI> revisions;
  final String? errorMessage;
  final int totalMinutes;
  final VoidCallback onStartRevision;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (isLoading && revisions.isEmpty) {
      return Center(
        child: CircularProgressIndicator(color: scheme.primary),
      );
    }
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacings.xl2),
          child: Text(
            revisionHubLoadError,
            textAlign: TextAlign.center,
            style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      );
    }

    final pending = revisions.length;

    return Scaffold(
      appBar: DsNavigationBar(
        title: revisionHubTitle,
        description: revisionHubEstimatedTime(totalMinutes),
        trailingWidget: Visibility(
          visible: pending > 0,
          child: DsBadge(
            label: revisionHubPendingBadge(pending),
            variant: BadgeVariant.highlight,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacings.l,
                AppSpacings.l,
                AppSpacings.l,
                AppSpacings.m,
              ),
              children: [
                const SizedBox(height: AppSpacings.xl2),
                for (var i = 0; i < revisions.length; i++) ...[
                  if (i > 0) const SizedBox(height: AppSpacings.l),
                  _RevisionCard(revision: revisions[i]),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacings.l,
              AppSpacings.xl2,
              AppSpacings.l,
              AppSpacings.xs2,
            ),
            child: PrimaryButton(
              label: revisionHubStartCta(pending),
              leadingIcon: Icons.psychology_rounded,
              isExpanded: true,
              enabled: pending > 0,
              action: onStartRevision,
            ),
          ),
        ],
      ),
    );
  }
}

class _RevisionCard extends StatelessWidget {
  const _RevisionCard({required this.revision});

  final RevisionIntroUI revision;

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
    final desc = revision.minutes;

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
