import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_body.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_event.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_state.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_view_model.dart';
import 'package:auror/core/di/di.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Today's pending revisions: list + primary CTA (embedded under dashboard tab).
class RevisionHubPage extends StatelessWidget {
  const RevisionHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<RevisionHubViewModel>()
            ..add(const RevisionHubEvent.loadRequested()),
      child: BlocBuilder<RevisionHubViewModel, RevisionHubState>(
        builder: (context, state) {
          final viewModel = context.watch<RevisionHubViewModel>();
          return SafeArea(
            child: RevisionHubBody(
              isLoading: state.isLoading && state.revisions.isEmpty,
              revisions: state.revisions,
              errorMessage: state.errorMessage,
              totalMinutes: state.totalMinutes,
              onStartRevision: () async {
                if (!context.mounted) {
                  return;
                }
                await context.router.root.push(
                  RevisionQuizRoute(revisions: viewModel.revisions),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
