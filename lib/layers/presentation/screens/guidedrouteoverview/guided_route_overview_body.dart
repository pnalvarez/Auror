import 'package:auror/common/strings/guided_route_overview_strings.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_state.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/organisms/feedback/shimmer_rectangle.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// UI for [GuidedRouteOverviewPage]. Navigation and side effects stay in the page.
class GuidedRouteOverviewBody extends StatelessWidget {
  const GuidedRouteOverviewBody({
    super.key,
    required this.state,
    required this.onRetry,
  });

  final GuidedRouteOverviewState state;
  final VoidCallback onRetry;

  static const int loadingModuleSkeletonCount = 3;

  /// Narrower than [loadingSubtitleShimmerWidth] — reads as a loading title line.
  static const double loadingTitleShimmerWidth = 140;

  /// Wider than the title shimmer — reads as a loading subtitle line.
  static const double loadingSubtitleShimmerWidth = 240;

  static const BorderRadius loadingHeaderShimmerRadius = BorderRadius.all(
    Radius.circular(AppRadius.s),
  );

  @override
  Widget build(BuildContext context) {
    final isLoading = state.isLoading;
    final overview = state.overview;

    return Scaffold(
      appBar: DsNavigationBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () => context.router.maybePop(),
        title: isLoading ? '' : (overview?.title ?? ''),
        titleWidget: isLoading
            ? const ShimmerRectangle(
                width: loadingTitleShimmerWidth,
                height: 22,
                borderRadius: loadingHeaderShimmerRadius,
              )
            : null,
        description: isLoading ? null : overview?.subtitle,
        descriptionWidget: isLoading
            ? const ShimmerRectangle(
                width: loadingSubtitleShimmerWidth,
                height: 14,
                borderRadius: loadingHeaderShimmerRadius,
              )
            : null,
      ),
      body: SafeArea(
        child: _GuidedRouteOverviewBodyContent(
          state: state,
          onRetry: onRetry,
        ),
      ),
    );
  }
}

class _GuidedRouteOverviewBodyContent extends StatelessWidget {
  const _GuidedRouteOverviewBodyContent({
    required this.state,
    required this.onRetry,
  });

  final GuidedRouteOverviewState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (state.errorMessage != null) {
      return _GuidedRouteOverviewErrorBody(onRetry: onRetry);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacings.l),
      child: state.isLoading
          ? const _GuidedRouteOverviewLoadingList()
          : _GuidedRouteOverviewModuleList(
              inputs: state.overview?.moduleListItemInputs ?? const [],
            ),
    );
  }
}

class _GuidedRouteOverviewErrorBody extends StatelessWidget {
  const _GuidedRouteOverviewErrorBody({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacings.xl2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              guidedRouteOverviewLoadErrorMessage,
              textAlign: TextAlign.center,
              style: body2Medium.copyWith(color: onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacings.xl2),
            PrimaryButton(
              label: guidedRouteOverviewRetryLabel,
              brand: ButtonBrand.error,
              isExpanded: true,
              action: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidedRouteOverviewLoadingList extends StatelessWidget {
  const _GuidedRouteOverviewLoadingList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: GuidedRouteOverviewBody.loadingModuleSkeletonCount,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacings.l),
      itemBuilder: (context, index) => const _GuidedRouteOverviewModuleShimmer(),
    );
  }
}

class _GuidedRouteOverviewModuleList extends StatelessWidget {
  const _GuidedRouteOverviewModuleList({required this.inputs});

  final List<TitleProgressStepsInput> inputs;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: inputs.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacings.l),
      itemBuilder: (context, index) => ListItem(input: inputs[index]),
    );
  }
}

/// Skeleton for a [TitleProgressStepsInput] module card while overview loads.
class _GuidedRouteOverviewModuleShimmer extends StatelessWidget {
  const _GuidedRouteOverviewModuleShimmer();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final brandStyle = ListItemBrandStyle.resolve(ListItemBrand.neutral, scheme);
    final cardRadius = BorderRadius.circular(AppRadius.m);
    final stepRadius = BorderRadius.circular(AppRadius.m);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: brandStyle.backgroundColor,
        borderRadius: cardRadius,
        border: Border.all(
          color: brandStyle.borderColor,
          width: brandStyle.borderWidth,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.l,
          vertical: AppSpacings.m,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ShimmerRectangle(width: 180, height: 18),
            const SizedBox(height: AppSpacings.xs),
            const ShimmerRectangle(width: 110, height: 12),
            const SizedBox(height: AppSpacings.m),
            ShimmerRectangle(
              width: double.infinity,
              height: 6,
              borderRadius: BorderRadius.circular(AppRadius.full(6)),
            ),
            const SizedBox(height: AppSpacings.l),
            ShimmerRectangle(
              width: double.infinity,
              height: 52,
              borderRadius: stepRadius,
            ),
            const SizedBox(height: AppSpacings.m),
            ShimmerRectangle(
              width: double.infinity,
              height: 52,
              borderRadius: stepRadius,
            ),
          ],
        ),
      ),
    );
  }
}
