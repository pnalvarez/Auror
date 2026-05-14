import 'package:auror/common/strings/explore_strings.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:flutter/material.dart';

/// Initial loading state for [ExplorePage].
class ExploreLoadingBody extends StatelessWidget {
  const ExploreLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularLoader(
        color: Theme.of(context).colorScheme.primary,
        size: 40,
        strokeWidth: 2,
      ),
    );
  }
}

/// Empty / failed feed state for [ExplorePage].
class ExploreErrorBody extends StatelessWidget {
  const ExploreErrorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacings.xl2),
        child: Text(
          exploreLoadError,
          textAlign: TextAlign.center,
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
