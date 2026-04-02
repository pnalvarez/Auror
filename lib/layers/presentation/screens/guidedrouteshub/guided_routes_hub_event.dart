import 'package:freezed_annotation/freezed_annotation.dart';

part 'guided_routes_hub_event.freezed.dart';

@freezed
sealed class GuidedRoutesHubEvent with _$GuidedRoutesHubEvent {
  const factory GuidedRoutesHubEvent.loadRequested() =
      GuidedRoutesHubLoadRequested;

  const factory GuidedRoutesHubEvent.routeSelected({required int index}) =
      GuidedRoutesHubRouteSelected;
}
