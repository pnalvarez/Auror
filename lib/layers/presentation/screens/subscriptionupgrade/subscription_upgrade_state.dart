import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_upgrade_state.freezed.dart';

@freezed
sealed class SubscriptionUpgradeState with _$SubscriptionUpgradeState {
  const factory SubscriptionUpgradeState({
    @Default(true) bool isLoading,
    @Default([]) List<SubscriptionUI> subscriptions,
    String? errorMessage,
  }) = _SubscriptionUpgradeState;
}
