import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/badges/badge.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/designsystem/molecules/dropdown/ds_dropdown.dart';
import 'package:auror/common/designsystem/organisms/list_item/list_item.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:auror/common/strings/explore_strings.dart';
import 'package:auror/common/strings/recall_card_strings.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/presentation/screens/explore/explore_video_background.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_event.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_state.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RecallCardPage extends StatelessWidget {
  const RecallCardPage({super.key, required this.card});

  final KnowledgeCardDomain card;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RecallCardViewModel>(param1: card),
      child: Theme(data: mainLaunchDarkTheme(), child: _RecallCardScaffold()),
    );
  }
}

class _RecallCardScaffold extends StatelessWidget {
  const _RecallCardScaffold();

  static const double _heroMaxHeight = 280;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final mq = MediaQuery.sizeOf(context);
    final heroHeight = (mq.height * 0.34).clamp(200.0, _heroMaxHeight);
    final viewModel = context.read<RecallCardViewModel>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: heroHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ExploreVideoBackground(
                    videoUrl: viewModel.card.videoUrl,
                    showScrim: true,
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
            Padding(
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
                  DsDropdown(
                    label: commonPracticalExampleTitle,
                    onExpansionChanged: (expanded) {
                      viewModel.add(
                        RecallCardEvent.practicalExampleExpansionChanged(),
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
                  const SizedBox(height: AppSpacings.xl3),
                  DsDropdown(
                    label: commonErrorTitle,
                    onExpansionChanged: (expanded) {
                      viewModel.add(
                        RecallCardEvent.commonErrorExpansionChanged(),
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
                  const SizedBox(height: AppSpacings.xl3),
                  BlocBuilder<RecallCardViewModel, RecallCardState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        label: proceed,
                        loading: state.isLoading,
                        enabled: state.isProceedCTAEnabled,
                        action: () => context.read<RecallCardViewModel>().add(
                          const RecallCardEvent.proceedButtonTapped(),
                        ),
                      );
                    },
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
