import 'package:freezed_annotation/freezed_annotation.dart';
part 'onboarding_real_example_state.freezed.dart';

@freezed
sealed class OnboardingRealExampleState with _$OnboardingRealExampleState {
  OnboardingRealExampleState._();

  factory OnboardingRealExampleState.initial() =
      OnboardingRealExampleStateInitial;

  factory OnboardingRealExampleState.recallCardRevealed(bool hasActiveSession) =
      OnboardingRealExampleStateRecallCardRevealed;

  bool get recallCardRevealed => switch (this) {
    OnboardingRealExampleStateInitial() => false,
    OnboardingRealExampleStateRecallCardRevealed() => true,
  };
}
