import 'package:freezed_annotation/freezed_annotation.dart';

part 'guided_route_overview_event.freezed.dart';

@freezed
sealed class GuidedRouteOverviewEvent with _$GuidedRouteOverviewEvent {
  const factory GuidedRouteOverviewEvent.loadRequested() = GuidedRouteOverviewLoadRequested;
}

