import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/home/home_body.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror/layers/domain/models/idea_track_flow_args.dart';
import 'package:auror/layers/presentation/screens/home/home_event.dart';
import 'package:auror/layers/presentation/screens/home/home_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeViewModel>(),
      child: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent>
    with AutoRouteAwareStateMixin<_HomeContent> {
  void _dispatchStarted() {
    context.read<HomeViewModel>().add(HomeEvent.started());
  }

  @override
  void didInitTabRoute(TabPageRoute? previousRoute) {
    _dispatchStarted();
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {
    _dispatchStarted();
  }

  @override
  void didPopNext() {
    _dispatchStarted();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacings.xl2),
          child: HomeBody(
            isLoading: viewModel.state.isLoading,
            userName: viewModel.state.userName ?? '',
            totalRevisionTime: viewModel.state.totalRevisionTime ?? 0,
            totalTimeToLearnDailyIdea:
                viewModel.state.totalTimeToLearnDailyIdea ?? 0,
            revisions: viewModel.state.revisions,
            tomorrowRevisionsCount: viewModel.state.tomorrowRevisions ?? 0,
            dailyIdeaCards: viewModel.state.dailyIdea?.cards ?? 0,
            dailyIdeaProgress: viewModel.state.dailyIdea?.progress ?? 0,
            dailyIdeaTotal: viewModel.state.dailyIdea?.total ?? 0,
            onDailyIdeaCtaTap: () {
              final track = viewModel.state.dailyIdeaTrackCards;
              if (track.isEmpty) return;
              context.router.push(
                RecallCardRoute(
                  card: track.first,
                  ideaTrackFlow: IdeaTrackFlowArgs(
                    cards: track,
                    currentIndex: 0,
                  ),
                ),
              );
            },
            onSeeMoreRevisions: () {
              context.router.navigate(DashboardRevisionHubRoute());
            },
          ),
        ),
      ),
    );
  }
}
