import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/badges/badge.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/molecules/cards/feedback_tile.dart';
import 'package:auror_design_system/molecules/inputfields/input_field.dart';
import 'package:auror_design_system/molecules/progress/step_progress_bar.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:auror/common/strings/revision_quiz_strings.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/domain/models/idea_track_flow_args.dart';
import 'package:auror/layers/domain/models/revision_domain.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/first_revision_completed_dialog.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_registered_dialog.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_factory_args.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_view_model.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_event.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_state.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_video.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';

typedef _BlocBuilder = BlocBuilder<RevisionQuizViewModel, RevisionQuizState>;

@RoutePage()
class RevisionQuizPage extends StatelessWidget {
  const RevisionQuizPage({
    super.key,
    required this.revisions,
    this.cardId,
    this.ideaTrackFlow,
  });

  final List<RevisionDomain> revisions;
  final String? cardId;
  final IdeaTrackFlowArgs? ideaTrackFlow;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final vm = getIt<RevisionQuizViewModel>(
          param1: revisions,
          param2: RevisionQuizFactoryArgs(
            cardId: cardId,
            ideaTrackFlow: ideaTrackFlow,
          ),
        );
        vm.add(const RevisionQuizEvent.started());
        return vm;
      },
      child: Theme(
        data: mainLaunchDarkTheme(),
        child: const _RevisionQuizScaffold(),
      ),
    );
  }
}

class _RevisionQuizScaffold extends StatelessWidget {
  const _RevisionQuizScaffold();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: _BlocBuilder(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularLoader(color: scheme.primary));
            }
            if (state.allRevisions.isEmpty) {
              return Center(
                child: Text(
                  'Nenhuma revisão disponível.',
                  style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
                ),
              );
            }
            return const _RevisionQuizBody();
          },
        ),
      ),
    );
  }
}

class _RevisionQuizBody extends StatelessWidget {
  const _RevisionQuizBody();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final viewModel = context.read<RevisionQuizViewModel>();

    return MultiBlocListener(
      listeners: [
        BlocListener<RevisionQuizViewModel, RevisionQuizState>(
          listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
          listener: (context, _) {
            viewModel.add(const RevisionQuizEvent.clearAnswerDraft());
          },
        ),
        BlocListener<RevisionQuizViewModel, RevisionQuizState>(
          listenWhen: (prev, curr) =>
              !prev.shouldPopRoute && curr.shouldPopRoute,
          listener: (context, _) {
            context.router.maybePop();
            viewModel.add(const RevisionQuizEvent.shouldPopConsumed());
          },
        ),
      ],
      child: _BlocBuilder(
        builder: (context, state) {
          final item = state.currentRevision;
          final step = state.currentIndex + 1;
          final total = state.allRevisions.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.allRevisions.length > 1)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacings.s,
                    AppSpacings.xs,
                    AppSpacings.l,
                    AppSpacings.xs,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: StepProgressBar(
                          currentValue: step,
                          totalValue: total,
                          showLabel: false,
                        ),
                      ),
                      const SizedBox(width: AppSpacings.s),
                      Text(
                        '$step/$total',
                        style: tagS.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacings.xs,
                  0,
                  AppSpacings.l,
                  AppSpacings.s,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Root stack: [DashboardRoute, ...pushed]. Tab pages are nested,
                        // so match [DashboardRoute.name] (not DashboardHomeRoute).
                        context.router.popUntilRouteWithName(
                          DashboardRoute.name,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: scheme.onSurfaceVariant,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                    Text(
                      revisionQuizNavLabel,
                      style: body3Light.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacings.l,
                    AppSpacings.s,
                    AppSpacings.l,
                    AppSpacings.xl2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (item != null) ...[
                        RevisionQuizVideo(videoUrl: item.videoUrl),
                        const SizedBox(height: AppSpacings.xl2),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: DsBadge(
                            label: item.category,
                            variant: BadgeVariant.neutral,
                          ),
                        ),
                        const SizedBox(height: AppSpacings.m),
                        Text(
                          item.title,
                          style: headlineXs.copyWith(
                            color: scheme.onSurface,
                            height: 1.25,
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacings.s),
                      Text(
                        revisionQuizInstruction,
                        style: body4Light.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                      if (state.deepMode && !state.answerRevealed) ...[
                        const SizedBox(height: AppSpacings.xl2),
                        InputField(
                          label: '',
                          controller: viewModel.answerDraftController,
                          appearance: InputFieldAppearance.theme,
                          onChanged: (text) => context
                              .read<RevisionQuizViewModel>()
                              .add(RevisionQuizEvent.answerDraftChanged(text)),
                          minLines: 4,
                          maxLines: 8,
                        ),
                        const SizedBox(height: AppSpacings.m),
                        Center(
                          child: TertiaryButton(
                            enabled: state.isSendAnswerCTAEnabled,
                            label: revisionQuizSendAnswer,
                            leadingIcon: Icons.edit_outlined,
                            brand: ButtonBrand.primary,
                            action: () {
                              FocusScope.of(context).unfocus();
                              final text = viewModel.answerDraftController.text
                                  .trim();
                              context.read<RevisionQuizViewModel>().add(
                                RevisionQuizEvent.answerSent(text),
                              );
                            },
                          ),
                        ),
                      ],
                      if (state.answerRevealed && item != null) ...[
                        const SizedBox(height: AppSpacings.xl2),
                        ListItem(
                          input: IconTitleParagraphInput(
                            title: revisionQuizExpectedLabel,
                            description: item.correctAnswer,
                          ),
                          brand: ListItemBrand.success,
                          isExpanded: true,
                        ),
                      ],
                      if (state.shouldShowAnswerSentDisclaimer) ...[
                        const SizedBox(height: AppSpacings.m),
                        ListItem(
                          input: TextInput(
                            text: revisionQuizAnswerSentDisclaimer,
                          ),
                          brand: ListItemBrand.warning,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (state.answerRevealed)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacings.l,
                    AppSpacings.s,
                    AppSpacings.l,
                    AppSpacings.m,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        revisionQuizFeedbackHeading,
                        textAlign: TextAlign.center,
                        style: body3Light.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: AppSpacings.m),
                      _FeedbackRow(
                        lessonTitle: item?.title ?? '',
                        isFinalRevision:
                            state.currentIndex == state.allRevisions.length - 1,
                        onContinue: () async {
                          final stackRouter = context.router;
                          final rootRouter = stackRouter.root;
                          final isFinal =
                              state.currentIndex ==
                              state.allRevisions.length - 1;
                          final singleRevision = state.allRevisions.length == 1;
                          final revisionCount = state.allRevisions.length;
                          final ideaFlow = viewModel.ideaTrackFlow;

                          await stackRouter.maybePop();

                          if (!isFinal) {
                            viewModel.add(
                              const RevisionQuizEvent.advanceAfterFeedback(),
                            );
                            return;
                          }

                          if (ideaFlow != null) {
                            if (ideaFlow.hasNextCard) {
                              final nextFlow = ideaFlow.advanceToNextCard();
                              await stackRouter.replace(
                                RecallCardRoute(
                                  card: nextFlow.cards[nextFlow.currentIndex],
                                  ideaTrackFlow: nextFlow,
                                ),
                              );
                              return;
                            }
                            await rootRouter.push(
                              SuccessRoute(revisionCount: ideaFlow.totalCards),
                            );
                            return;
                          }
                          if (singleRevision) {
                            await showFirstRevisionCompletedDialogForRouter(
                              rootRouter,
                            );
                          } else {
                            await rootRouter.push(
                              SuccessRoute(revisionCount: revisionCount),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              if (!state.answerRevealed)
                _CTAStack(
                  deepMode: state.deepMode,
                  onToggleDeepMode: () => context
                      .read<RevisionQuizViewModel>()
                      .add(const RevisionQuizEvent.deepModeToggled()),
                  deepModeEnabled: state.deepModeCTAEnabled,
                  revealAnswerEnabled: state.revealAnswerCTAEnabled,
                  onRevealAnswer: () => context
                      .read<RevisionQuizViewModel>()
                      .add(const RevisionQuizEvent.revealAnswer()),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _CTAStack extends StatelessWidget {
  final bool deepMode;
  final bool deepModeEnabled;
  final bool revealAnswerEnabled;
  final Function onToggleDeepMode;
  final Function onRevealAnswer;

  const _CTAStack({
    required this.deepMode,
    required this.deepModeEnabled,
    required this.revealAnswerEnabled,
    required this.onToggleDeepMode,
    required this.onRevealAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacings.l,
        AppSpacings.s,
        AppSpacings.l,
        AppSpacings.m,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryButton(
            label: revisionQuizDeepMode,
            leadingIcon: Icons.edit_outlined,
            brand: deepMode ? ButtonBrand.tertiary : ButtonBrand.secondary,
            isExpanded: true,
            enabled: deepModeEnabled,
            action: onToggleDeepMode as VoidCallback,
          ),
          const SizedBox(height: AppSpacings.m),
          SecondaryButton(
            label: revisionQuizShowAnswer,
            leadingIcon: Icons.visibility_outlined,
            brand: ButtonBrand.primary,
            isExpanded: true,
            enabled: revealAnswerEnabled,
            action: onRevealAnswer as VoidCallback,
          ),
        ],
      ),
    );
  }
}

class _FeedbackRow extends StatelessWidget {
  const _FeedbackRow({
    required this.lessonTitle,
    required this.onContinue,
    required this.isFinalRevision,
  });

  final String lessonTitle;
  final bool isFinalRevision;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    void openDialog(RevisionFeedbackSchedule schedule) {
      showRevisionRegisteredDialog(
        context,
        lessonTitle: lessonTitle,
        ctaText: isFinalRevision ? finalize : nextRevision,
        schedule: schedule,
        onContinue: onContinue,
      );
    }

    return Row(
      children: [
        Expanded(
          child: FeedbackTile(
            state: FeedbackTileState.error,
            title: revisionQuizFeedbackNone,
            subtitle: revisionQuizFeedbackNoneMeta,
            onTap: () => openDialog(RevisionFeedbackSchedule.nextDay),
          ),
        ),
        const SizedBox(width: AppSpacings.s),
        Expanded(
          child: FeedbackTile(
            state: FeedbackTileState.warning,
            title: revisionQuizFeedbackPartial,
            subtitle: revisionQuizFeedbackPartialMeta,
            onTap: () => openDialog(RevisionFeedbackSchedule.threeDays),
          ),
        ),
        const SizedBox(width: AppSpacings.s),
        Expanded(
          child: FeedbackTile(
            state: FeedbackTileState.success,
            title: revisionQuizFeedbackFull,
            subtitle: revisionQuizFeedbackFullMeta,
            onTap: () => openDialog(RevisionFeedbackSchedule.sevenDays),
          ),
        ),
      ],
    );
  }
}
