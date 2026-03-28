import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_launch_state.freezed.dart';

@freezed
class MainLaunchState with _$MainLaunchState {
  const factory MainLaunchState.initial() = MainLaunchStateInitial;

  /// Resolving session / bootstrap (auth, local prefs, etc.).
  const factory MainLaunchState.loading() = MainLaunchStateLoading;

  /// Interactive landing; [hasActiveSession] drives primary CTA copy.
  const factory MainLaunchState.ready({
    @Default(false) bool hasActiveSession,
  }) = MainLaunchStateReady;
}
