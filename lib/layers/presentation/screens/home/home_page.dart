import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/badges/badge.dart';
import 'package:auror/common/designsystem/organisms/feedback/circular_loader.dart';
import 'package:auror/common/designsystem/organisms/list_item/list_item.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/screens/home/home_event.dart';
import 'package:auror/layers/presentation/screens/home/home_state.dart';
import 'package:auror/layers/presentation/screens/home/home_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef _BlocBuilder = BlocBuilder<HomeViewModel, HomeState>;

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
    final scheme = Theme.of(context).colorScheme;
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacings.xl2),
          child: Builder(
            builder: (context) {
              if (viewModel.state.isLoading) {
                return Center(child: CircularLoader(color: scheme.primary));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HomeHeader(
                    userName: viewModel.state.userName ?? '',
                    totalRevisionTime: viewModel.state.totalRevisionTime ?? 0,
                    totalTimeToLearnDailyIdea:
                        viewModel.state.totalTimeToLearnDailyIdea ?? 0,
                  ),
                  const SizedBox(height: AppSpacings.xl3),
                  _SectionHeader(
                    title: 'Revisões pendentes',
                    icon: Icons.psychology_rounded,
                    badgeText: viewModel.state.revisions.length.toString(),
                  ),
                  const SizedBox(height: AppSpacings.xl3),
                  _SectionHeader(
                    title: 'Novas ideias',
                    icon: Icons.info_outline,
                  ),
                  const SizedBox(height: AppSpacings.l),
                  ListItem(
                    input: TitleDescriptionCTAProgressInput(
                      title: 'Descubra algo novo',
                      description:
                          '${viewModel.state.dailyIdea?.cards ?? 0} ideias selecionadas para você',
                      ctaText: 'Aprender agora',
                      onCtaTap: () {},
                      currentProgress: 1,
                      totalProgress: 3,
                    ),
                  ),
                ],
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
        Text('Olá, $userName', style: headingH3),
        const SizedBox(height: AppSpacings.s),
        Text.rich(
          TextSpan(
            style: body4Light,
            children: [
              const TextSpan(text: 'Hoje você tem '),
              TextSpan(text: '$totalRevisionTime min', style: body4Semibold),
              const TextSpan(text: ' de revisão + '),
              TextSpan(
                text: '$totalTimeToLearnDailyIdea min',
                style: body4Semibold,
              ),
              const TextSpan(text: ' para aprender a ideia do dia.'),
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
        if (badgeText != null) DsBadge(label: badgeText!),
      ],
    );
  }
}
