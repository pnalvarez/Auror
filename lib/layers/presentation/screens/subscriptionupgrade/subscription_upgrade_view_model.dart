import 'package:auror/common/strings/subscription_upgrade_strings.dart';
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
  SubscriptionUpgradeViewModel(this._getSubscriptions, this._selectSubscription)
    : super(const SubscriptionUpgradeState()) {
    on<SubscriptionUpgradeStarted>(_onStarted);
    on<SubscriptionUpgradeSelected>(_onSelect);
  }

  final IGetSubscriptions _getSubscriptions;
  final ISelectSubscription _selectSubscription;

  Future<void> _onStarted(
    SubscriptionUpgradeStarted event,
    Emitter<SubscriptionUpgradeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await _getSubscriptions();
      emit(
        state.copyWith(
          isLoading: false,
          subscriptions: response
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
    await _selectSubscription(id: event.id);
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
