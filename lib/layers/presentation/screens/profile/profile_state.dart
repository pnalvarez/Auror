import 'package:auror/layers/presentation/screens/profile/profile_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(true) bool isLoadingData,
    ProfileUI? profile,
    String? errorMessage,
    @Default(false) bool pendingMainLaunchNavigation,
    @Default(false) bool pendingLogoutNavigation,
  }) = _ProfileState;
}
