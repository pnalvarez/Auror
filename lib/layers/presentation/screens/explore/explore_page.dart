import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/badges/badge.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/molecules/chips/chip_picker.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:auror/common/strings/explore_strings.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/presentation/screens/explore/explore_event.dart';
import 'package:auror/layers/presentation/screens/explore/explore_state.dart';
import 'package:auror/layers/presentation/screens/explore/explore_video_background.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/explore/explore_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';

/// Explore tab: full-bleed video per page (draggable with vertical feed), chips on top.
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ExploreViewModel>()..add(const ExploreEvent.started()),
      child: const _ExploreScaffold(),
    );
  }
}

class _ExploreScaffold extends StatelessWidget {
  const _ExploreScaffold();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExploreViewModel, ExploreState>(
      listenWhen: (prev, next) =>
          prev.errorMessage != next.errorMessage &&
          next.errorMessage != null &&
          next.errorMessage!.isNotEmpty,
      listener: (context, state) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      },
      child: BlocBuilder<ExploreViewModel, ExploreState>(
        builder: (context, state) {
          if (state.isLoadingInitial) {
            return Center(
              child: CircularLoader(
                color: Theme.of(context).colorScheme.primary,
                size: 40,
                strokeWidth: 2,
              ),
            );
          }
          if (state.chipLabels.isEmpty || state.cardSlots.isEmpty) {
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
          return _ExploreFeed(state: state);
        },
      ),
    );
  }
}

class _ExploreFeed extends StatefulWidget {
  const _ExploreFeed({required this.state});

  final ExploreState state;

  @override
  State<_ExploreFeed> createState() => _ExploreFeedState();
}

class _ExploreFeedState extends State<_ExploreFeed> {
  late final PageController _pageController;
  int _visiblePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _ExploreFeed oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.feedRevision != oldWidget.state.feedRevision) {
      setState(() => _visiblePage = 0);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        if (_pageController.hasClients) {
          _pageController.jumpToPage(0);
        }
        context.read<ExploreViewModel>().add(
              const ExploreEvent.pageBecameVisible(0),
            );
      });
    }
  }

  String _videoUrlForSlot(int index) {
    final slots = widget.state.cardSlots;
    if (index < 0 || index >= slots.length) {
      return '';
    }
    return slots[index]?.videoUrl.trim() ?? '';
  }

  Future<void> _goToNextPage() async {
    final last = widget.state.cardSlots.length - 1;
    if (_visiblePage >= last) {
      return;
    }
    await _pageController.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final slots = widget.state.cardSlots;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Single video surface: one [VideoPlayerController] at a time (see [ExploreVideoBackground]).
        // PageView pages only carry overlays; they do not each host a player.
        Positioned.fill(
          child: ExploreVideoBackground(
            videoUrl: _videoUrlForSlot(_visiblePage),
            showScrim: false,
          ),
        ),
        PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: slots.length,
          onPageChanged: (i) {
            setState(() => _visiblePage = i);
            context.read<ExploreViewModel>().add(
                  ExploreEvent.pageBecameVisible(i),
                );
          },
          itemBuilder: (context, index) {
            final card = slots[index];
            final showPageSpinner = widget.state.isLoadingCard &&
                card == null &&
                index == _visiblePage;

            return Stack(
              fit: StackFit.expand,
              children: [
                if (showPageSpinner)
                  Center(
                    child: CircularLoader(
                      color: scheme.primary,
                      size: 44,
                      strokeWidth: 2.5,
                    ),
                  ),
                _ExplorePagePanel(
                  card: card,
                  pageIndex: index,
                  scheme: scheme,
                  canGoNext: index < slots.length - 1,
                  onNext: _goToNextPage,
                ),
              ],
            );
          },
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacings.xl2,
                AppSpacings.m,
                AppSpacings.xl2,
                AppSpacings.s,
              ),
              child: ChipPicker(
                items: widget.state.chipLabels,
                selectedIndex: widget.state.selectedChipIndex,
                onSelected: (i) => context.read<ExploreViewModel>().add(
                      ExploreEvent.chipSelected(i),
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Single bottom card + CTAs; lives inside each [PageView] page so it scrolls with the video.
class _ExplorePagePanel extends StatelessWidget {
  const _ExplorePagePanel({
    required this.card,
    required this.pageIndex,
    required this.scheme,
    required this.canGoNext,
    required this.onNext,
  });

  final KnowledgeCardDomain? card;
  final int pageIndex;
  final ColorScheme scheme;
  final bool canGoNext;
  final VoidCallback onNext;

  static const _kTextShadows = [
    Shadow(blurRadius: 12, color: Color(0x88000000), offset: Offset(0, 1)),
    Shadow(blurRadius: 24, color: Color(0x66000000), offset: Offset(0, 2)),
  ];

  @override
  Widget build(BuildContext context) {
    final content = card;

    return Positioned(
      left: AppSpacings.xl2,
      right: AppSpacings.xl2,
      bottom: 0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSpacings.m),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacings.xl2),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(AppRadius.xl2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (content != null) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: DsBadge(
                          label: content.category,
                          variant: BadgeVariant.tertiary,
                        ),
                      ),
                      const SizedBox(width: AppSpacings.s),
                      DsBadge(
                        label: '$exploreDayBadgePrefix ${pageIndex + 1}',
                        leadingIcon: Icons.link_rounded,
                        variant: BadgeVariant.surfaceOverlay,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacings.xl2),
                  Text(
                    content.title,
                    style: headlineS.copyWith(
                      color: Colors.white,
                      height: 1.2,
                      shadows: _kTextShadows,
                    ),
                  ),
                  const SizedBox(height: AppSpacings.m),
                  Text(
                    '"${content.quote}"',
                    style: body3Medium.copyWith(
                      color: AppColors.DarkContent.accent,
                      fontStyle: FontStyle.italic,
                      height: 1.35,
                      shadows: _kTextShadows,
                    ),
                  ),
                  const SizedBox(height: AppSpacings.xl),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white.withValues(alpha: 0.9),
                      size: 28,
                      shadows: _kTextShadows,
                    ),
                  ),
                  const SizedBox(height: AppSpacings.xl2),
                ],
                Row(
                  children: [
                    Flexible(
                      child: PrimaryButton(
                        label: seeMore,
                        trailingIcon: Icons.add,
                        isExpanded: true,
                        action: content == null
                            ? () {}
                            : () => context.router.root.push(
                                  RecallCardRoute(card: content),
                                ),
                      ),
                    ),
                    const SizedBox(width: AppSpacings.m),
                    Flexible(
                      child: PrimaryButton(
                        label: exploreNextButton,
                        brand: ButtonBrand.tertiary,
                        isExpanded: true,
                        trailingIcon: Icons.keyboard_arrow_down_rounded,
                        action: onNext,
                        enabled: canGoNext,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
