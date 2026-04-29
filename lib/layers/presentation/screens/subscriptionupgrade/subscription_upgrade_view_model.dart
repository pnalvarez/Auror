import 'package:auror/common/strings/subscription_upgrade_strings.dart';
import 'package:auror/layers/domain/models/subscription_domain.dart';
import 'package:auror/layers/domain/usecases/cancel_subscription.dart';
import 'package:auror/layers/domain/usecases/get_subscriptions.dart';
import 'package:auror/layers/domain/usecases/select_subscription.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_ui.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_event.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_state.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionUpgradeViewModel
    extends Bloc<SubscriptionUpgradeEvent, SubscriptionUpgradeState> {
  SubscriptionUpgradeViewModel(
    this._getSubscriptions,
    this._selectSubscription,
    this._cancelSubscription,
  ) : super(const SubscriptionUpgradeState()) {
    on<SubscriptionUpgradeStarted>(_onStarted);
    on<SubscriptionUpgradeSelected>(_onSelect);
    on<SubscriptionUpgradeCancel>(_onCancel);
    on<SubscriptionUpgradeSnackBarConsumed>(_onSnackBarConsumed);
  }

  final IGetSubscriptions _getSubscriptions;
  final ISelectSubscription _selectSubscription;
  final ICancelSubscription _cancelSubscription;

  Future<void> _onStarted(
    SubscriptionUpgradeStarted event,
    Emitter<SubscriptionUpgradeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await _getSubscriptions();
      final sortedByPrice = List<SubscriptionDomain>.from(response)
        ..sort((a, b) => a.price.compareTo(b.price));
      emit(
        state.copyWith(
          isLoading: false,
          subscriptions: sortedByPrice
              .map((elem) => SubscriptionUI.fromDomain(elem))
              .toList(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onSelect(
    SubscriptionUpgradeSelected event,
    Emitter<SubscriptionUpgradeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, snackBarMessage: null));
    try {
      await _selectSubscription(id: event.id);
      emit(
        state.copyWith(
          isLoading: false,
          shouldNavigateBack: true,
          snackBarMessage: subscriptionUpgradeSuccessChanged,
          snackBarIsError: false,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          shouldNavigateBack: false,
          snackBarMessage: subscriptionUpgradeErrorGeneric,
          snackBarIsError: true,
        ),
      );
    }
  }

  Future<void> _onCancel(
    SubscriptionUpgradeCancel event,
    Emitter<SubscriptionUpgradeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, snackBarMessage: null));
    try {
      await _cancelSubscription();
      emit(
        state.copyWith(
          isLoading: false,
          shouldNavigateBack: true,
          snackBarMessage: subscriptionUpgradeSuccessCancelled,
          snackBarIsError: false,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          shouldNavigateBack: false,
          snackBarMessage: subscriptionUpgradeErrorGeneric,
          snackBarIsError: true,
        ),
      );
    }
  }

  void _onSnackBarConsumed(
    SubscriptionUpgradeSnackBarConsumed event,
    Emitter<SubscriptionUpgradeState> emit,
  ) {
    emit(state.copyWith(snackBarMessage: null, snackBarIsError: false));
  }

  TitleDescriptionCheckpointsInputStyle getStyle({
    required String subscriptionId,
  }) {
    switch (subscriptionId) {
      case subscriptionUpgradeIdStandard:
        return TitleDescriptionCheckpointsInputStyle.standard;
      case subscriptionUpgradeIdPro:
        return TitleDescriptionCheckpointsInputStyle.tertiary;
      case subscriptionUpgradeIdUltra:
        return TitleDescriptionCheckpointsInputStyle.quaternary;
      default:
        return TitleDescriptionCheckpointsInputStyle.standard;
    }
  }
}
