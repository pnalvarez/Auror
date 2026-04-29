import 'package:auror/common/strings/subscription_upgrade_strings.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_event.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_state.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_view_model.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/organisms/feedback/ds_snackbar.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SubscriptionUpgradePage extends StatelessWidget {
  const SubscriptionUpgradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<SubscriptionUpgradeViewModel>()
            ..add(const SubscriptionUpgradeEvent.started()),
      child: const _SubscriptionUpgradeContent(),
    );
  }
}

class _SubscriptionUpgradeContent extends StatefulWidget {
  const _SubscriptionUpgradeContent();

  @override
  State<_SubscriptionUpgradeContent> createState() =>
      _SubscriptionUpgradeContentState();
}

class _SubscriptionUpgradeContentState
    extends State<_SubscriptionUpgradeContent> {
  final GlobalKey _ultraCellKey = GlobalKey();
  final GlobalKey _proCellKey = GlobalKey();
  final GlobalKey _standardCellKey = GlobalKey();

  bool _didAutoScrollToUltra = false;

  void _scheduleScrollToUltraOnce(SubscriptionUpgradeState state) {
    if (_didAutoScrollToUltra) return;
    if (state.isLoading || state.errorMessage != null) return;
    if (!state.subscriptions.any((s) => s.id == subscriptionUpgradeIdUltra)) {
      return;
    }

    _didAutoScrollToUltra = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final target = _ultraCellKey.currentContext;
      if (target == null) return;
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        alignment: 0.32,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SubscriptionUpgradeViewModel>();
    _scheduleScrollToUltraOnce(viewModel.state);
    final darkTheme = mainLaunchDarkTheme();

    return Theme(
      data: darkTheme,
      child: Material(
        color: darkTheme.scaffoldBackgroundColor,
        child: SafeArea(
          child: Scaffold(
            appBar: DsNavigationBar(
              leadingIcon: Icons.arrow_back,
              onLeadingTap: () => _popSubscriptionUpgrade(context),
              title: subscriptionUpgradeNavTitle,
              description: subscriptionUpgradeNavDescription,
            ),
            body:
                BlocListener<
                  SubscriptionUpgradeViewModel,
                  SubscriptionUpgradeState
                >(
                  listenWhen: (previous, current) =>
                      current.snackBarMessage != null &&
                      current.snackBarMessage != previous.snackBarMessage,
                  listener: (context, state) {
                    final message = state.snackBarMessage;
                    if (message == null) return;
                    showSnackbar(
                      context,
                      message: message,
                      state: state.snackBarIsError
                          ? DsSnackbarState.error
                          : DsSnackbarState.success,
                      hasCloseButton: true,
                    );
                    context.read<SubscriptionUpgradeViewModel>().add(
                      const SubscriptionUpgradeEvent.snackBarConsumed(),
                    );
                  },
                  child:
                      BlocListener<
                        SubscriptionUpgradeViewModel,
                        SubscriptionUpgradeState
                      >(
                        listenWhen: (previous, current) =>
                            previous.shouldNavigateBack !=
                            current.shouldNavigateBack,
                        listener: (context, state) {
                          if (state.shouldNavigateBack) {
                            context.router.maybePop();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: AppSpacings.m),
                          child: viewModel.state.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.separated(
                                  padding: const EdgeInsets.fromLTRB(
                                    AppSpacings.l,
                                    AppSpacings.m,
                                    AppSpacings.l,
                                    AppSpacings.xl2,
                                  ),
                                  itemBuilder: (context, index) {
                                    final item =
                                        viewModel.state.subscriptions[index];
                                    return ListItem(
                                      key: getKeyBySubscriptionId(item.id),
                                      isSelected: item.isSelected,
                                      isEnabled: !item.disabled,
                                      input: TitleDescriptionCheckpointsInput(
                                        style: viewModel.getStyle(
                                          subscriptionId: item.id,
                                        ),
                                        title: item.title,
                                        firstTrailingItem: item.price,
                                        secondTrailingItem: item.period,
                                        description: item.description,
                                        checkpoints: item.benefits,
                                        primaryCtaText: item.primaryCtaText,
                                        tertiaryCTAText: item.tertiaryCtaText,
                                        tertiaryCTAHasErrorBrandFixed:
                                            !item.hasDowngradeOption,
                                        onTapPrimaryCTA: () => viewModel.add(
                                          SubscriptionUpgradeEvent.selected(
                                            id: item.id,
                                          ),
                                        ),
                                        onTapTertiaryCTA: () {
                                          if (item.hasDowngradeOption) {
                                            viewModel.add(
                                              SubscriptionUpgradeEvent.selected(
                                                id: item.id,
                                              ),
                                            );
                                          } else {
                                            viewModel.add(
                                              SubscriptionUpgradeEvent.cancel(),
                                            );
                                          }
                                        },
                                        footerText: item.footerText,
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: AppSpacings.xl2,
                                        );
                                      },
                                  itemCount:
                                      viewModel.state.subscriptions.length,
                                ),
                        ),
                      ),
                ),
          ),
        ),
      ),
    );
  }

  GlobalKey? getKeyBySubscriptionId(String subscriptionId) {
    switch (subscriptionId) {
      case subscriptionUpgradeIdStandard:
        return _standardCellKey;
      case subscriptionUpgradeIdPro:
        return _proCellKey;
      case subscriptionUpgradeIdUltra:
        return _ultraCellKey;
      default:
        return null;
    }
  }
}

void _popSubscriptionUpgrade(BuildContext context) {
  final scope = StackRouterScope.of(context);
  if (scope != null && scope.controller.canPop()) {
    scope.controller.maybePop();
  } else {
    Navigator.of(context).maybePop();
  }
}
