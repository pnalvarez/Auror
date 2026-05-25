import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_state.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// UI for [GuidedRouteOverviewPage]. Navigation and side effects stay in the page.
class GuidedRouteOverviewBody extends StatelessWidget {
  const GuidedRouteOverviewBody({super.key, required this.state});

  final GuidedRouteOverviewState state;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (state.isLoading) {
      return Center(child: CircularProgressIndicator(color: scheme.primary));
    }
    if (state.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacings.xl2),
          child: Text(
            state.errorMessage!,
            textAlign: TextAlign.center,
            style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: DsNavigationBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () => context.router.maybePop(),
        title: state.overview?.title ?? '',
        description: state.overview?.subtitle ?? '',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacings.l),
          child: ListView.separated(
            itemBuilder: (context, index) => ListItem(
              input:
                  state.overview?.moduleListItemInputs[index] ??
                  GenericListItemInput(child: const SizedBox.shrink()),
            ),
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacings.l),
            itemCount: state.overview?.moduleListItemInputs.length ?? 0,
          ),
        ),
      ),
    );
  }
}
