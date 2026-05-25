import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'guided_route_overview_state.freezed.dart';

@freezed
sealed class GuidedRouteOverviewState with _$GuidedRouteOverviewState {
  const factory GuidedRouteOverviewState({
    @Default(true) bool isLoading,
    GuidedRouteOverviewUI? overview,
    String? errorMessage,
  }) = _GuidedRouteOverviewState;
}

