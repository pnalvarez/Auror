import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/badges/badge.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/designsystem/molecules/dropdown/ds_dropdown.dart';
import 'package:auror/common/designsystem/molecules/tooltip/ds_tooltip.dart';
import 'package:auror/common/designsystem/organisms/list_item/list_item.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:auror/common/strings/explore_strings.dart';
import 'package:auror/common/strings/recall_card_strings.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/explore/explore_video_background.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_event.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_state.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';

/// [RecallCardState.shouldFloatingButtonAppear] must be non-null; a null value
/// can surface after hot-reload when [RecallCardState] gains a field while old
/// state instances remain in memory.
bool _shouldFloatingButtonAppear(RecallCardState state) {
  try {
    return state.shouldFloatingButtonAppear;
  } catch (_) {
    return false;
  }
}

@RoutePage()
class RecallCardPage extends StatelessWidget {
  const RecallCardPage({super.key, required this.card});

  final KnowledgeCardDomain card;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RecallCardViewModel>(param1: card),
      child: Theme(
        data: mainLaunchDarkTheme(),
        child: const _RecallCardScaffold(),
      ),
    );
  }
}

class _RecallCardScaffold extends StatefulWidget {
  const _RecallCardScaffold();

  @override
  State<_RecallCardScaffold> createState() => _RecallCardScaffoldState();
}

class _RecallCardScaffoldState extends State<_RecallCardScaffold> {
  static const double _heroMaxHeight = 280;

  /// Matches [DsDropdown]'s [AnimatedSize] duration so layout is stable before
  /// [Scrollable.ensureVisible] runs.
  static const Duration _dropdownExpandDuration = Duration(milliseconds: 200);

  final ScrollController _scrollController = ScrollController();

  final GlobalKey _commonErrorSectionKey = GlobalKey();

  final GlobalKey _proceedCtaKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateProceedCtaViewportVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateProceedCtaViewportVisibility();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateProceedCtaViewportVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  /// Whether the proceed button's bounds overlap the screen's safe viewport.
  bool _isProceedCtaVisibleInScrollViewport() {
    final ctx = _proceedCtaKey.currentContext;
    if (ctx == null || !ctx.mounted) {
      return true;
    }
    final renderObject = ctx.findRenderObject();
    if (renderObject is! RenderBox ||
        !renderObject.hasSize ||
        !renderObject.attached) {
      return true;
    }
    final topLeft = renderObject.localToGlobal(Offset.zero);
    final widgetRect = topLeft & renderObject.size;

    final mq = MediaQuery.of(ctx);
    final safeTop = mq.padding.top;
    final safeBottom = mq.size.height - mq.padding.bottom;
    final viewportRect = Rect.fromLTWH(
      0,
      safeTop,
      mq.size.width,
      safeBottom - safeTop,
    );

    return viewportRect.overlaps(widgetRect);
  }

  void _updateProceedCtaViewportVisibility() {
    if (!mounted) return;
    final visible = _isProceedCtaVisibleInScrollViewport();
    context.read<RecallCardViewModel>().add(
      RecallCardEvent.proceedCtaViewportVisibilityChanged(isVisible: visible),
    );
  }

  /// Scrolls the minimum amount so the widget at [key] is on screen.
  void _ensureKeyVisibleAfterDropdownExpand(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(_dropdownExpandDuration, () async {
        if (!mounted) return;
        final targetContext = key.currentContext;
        if (targetContext == null || !targetContext.mounted) return;
        await Scrollable.ensureVisible(
          targetContext,
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
        );
        if (mounted) {
          _updateProceedCtaViewportVisibility();
        }
      });
    });
  }

  Widget _floatingButton() {
    return BlocBuilder<RecallCardViewModel, RecallCardState>(
      builder: (context, state) {
        if (!_shouldFloatingButtonAppear(state)) {
          return const SizedBox.shrink();
        }
        return PrimaryButton(
          label: '',
          brand: .secondary,
          action: () {
            final targetContext = _proceedCtaKey.currentContext;
            if (targetContext == null || !targetContext.mounted) return;
            Scrollable.ensureVisible(
              targetContext,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          mainIcon: Icons.arrow_downward_rounded,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final mq = MediaQuery.sizeOf(context);
    final heroHeight = (mq.height * 0.34).clamp(200.0, _heroMaxHeight);
    final viewModel = context.read<RecallCardViewModel>();

    return BlocListener<RecallCardViewModel, RecallCardState>(
      listenWhen: (previous, current) =>
          previous.isProceedCTAEnabled != current.isProceedCTAEnabled ||
          previous.isCommonErrorDropdownEnabled !=
              current.isCommonErrorDropdownEnabled,
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future<void>.delayed(_dropdownExpandDuration, () {
            if (!mounted) return;
            _updateProceedCtaViewportVisibility();
          });
        });
      },
      child: Scaffold(
        floatingActionButton: _floatingButton(),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: heroHeight,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    ExploreVideoBackground(
                      videoUrl: viewModel.card.videoUrl,
                      showScrim: false,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: AppSpacings.s,
                            top: AppSpacings.xs,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Material(
                              color: Colors.black.withValues(alpha: 0.35),
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                ),
                                color: Colors.white,
                                onPressed: () => context.router.maybePop(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ColoredBox(
                color: scheme.surface,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacings.xl2,
                    AppSpacings.xl2,
                    AppSpacings.xl2,
                    AppSpacings.xl3,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DsBadge(
                          label: viewModel.card.category,
                          variant: BadgeVariant.tertiary,
                        ),
                      ),
                      const SizedBox(height: AppSpacings.xl2),
                      Text(
                        viewModel.card.title,
                        style: headlineS.copyWith(
                          color: scheme.onSurface,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppSpacings.m),
                      Text(
                        '"${viewModel.card.quote}"',
                        style: body3Medium.copyWith(
                          color: AppColors.DarkContent.accent,
                          fontStyle: FontStyle.italic,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: AppSpacings.xl2),
                      Text(
                        viewModel.card.description,
                        style: body2Light.copyWith(
                          color: scheme.onSurface,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacings.xl3),
                      BlocBuilder<RecallCardViewModel, RecallCardState>(
                        builder: (context, state) {
                          return DsTooltip(
                            text: clickHereToCheck,
                            placement: DsTooltipPlacement.startTop,
                            visible: state.shouldDisplayPracticalExampleTooltip,
                            child: DsDropdown(
                              label: commonPracticalExampleTitle,
                              canCompress: false,
                              onExpansionChanged: (expanded) {
                                if (expanded) {
                                  _ensureKeyVisibleAfterDropdownExpand(
                                    _commonErrorSectionKey,
                                  );
                                }
                                viewModel.add(
                                  RecallCardEvent.practicalExampleExpansionChanged(
                                    expanded: expanded,
                                  ),
                                );
                              },
                              child: ListItem(
                                input: IconTitleParagraphInput(
                                  leadingIcon: Icons.lightbulb_outline_rounded,
                                  title: recallPracticalExampleTitle,
                                  description: viewModel.card.practicalExample,
                                ),
                                brand: ListItemBrand.warning,
                                isExpanded: true,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacings.xl3),
                      BlocBuilder<RecallCardViewModel, RecallCardState>(
                        builder: (context, state) {
                          return KeyedSubtree(
                            key: _commonErrorSectionKey,
                            child: DsTooltip(
                              text: clickHereToCheck,
                              placement: DsTooltipPlacement.startTop,
                              visible: state.shouldDisplayCommonErrorTooltip,
                              child: DsDropdown(
                                label: commonErrorTitle,
                                canCompress: false,
                                enabled: state.isCommonErrorDropdownEnabled,
                                onExpansionChanged: (expanded) {
                                  if (expanded) {
                                    _ensureKeyVisibleAfterDropdownExpand(
                                      _proceedCtaKey,
                                    );
                                  }
                                  viewModel.add(
                                    RecallCardEvent.commonErrorExpansionChanged(
                                      expanded: expanded,
                                    ),
                                  );
                                },
                                child: ListItem(
                                  input: IconTitleParagraphInput(
                                    leadingIcon: Icons.warning_amber_rounded,
                                    title: recallCommonErrorTitle,
                                    description: viewModel.card.commonError,
                                  ),
                                  brand: ListItemBrand.error,
                                  isExpanded: true,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacings.xl3),
                      BlocBuilder<RecallCardViewModel, RecallCardState>(
                        builder: (context, state) {
                          return KeyedSubtree(
                            key: _proceedCtaKey,
                            child: PrimaryButton(
                              label: proceed,
                              loading: state.isLoading,
                              enabled: state.isProceedCTAEnabled,
                              action: () {
                                context.router.push(
                                  RevisionQuizRoute(
                                    revisions: [],
                                    cardId: viewModel.card.id,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
