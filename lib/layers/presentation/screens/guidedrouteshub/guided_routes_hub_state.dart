import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'guided_routes_hub_state.freezed.dart';

@freezed
sealed class GuidedRoutesHubState with _$GuidedRoutesHubState {
  const factory GuidedRoutesHubState({
    @Default(true) bool isLoading,
    @Default(<GuidedRouteIntroUI>[]) List<GuidedRouteIntroUI> routes,
    @Default(false) bool isPremium,
    String? errorMessage,
  }) = _GuidedRoutesHubState;
}
