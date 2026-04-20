import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_upgrade_event.freezed.dart';

@freezed
sealed class SubscriptionUpgradeEvent with _$SubscriptionUpgradeEvent {
  const factory SubscriptionUpgradeEvent.started() = SubscriptionUpgradeStarted;
  const factory SubscriptionUpgradeEvent.selected({required String id}) =
      SubscriptionUpgradeSelected;
}
