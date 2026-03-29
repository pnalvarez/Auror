import 'package:freezed_annotation/freezed_annotation.dart';
part 'onboarding_real_example_state.freezed.dart';

@freezed
sealed class OnboardingRealExampleState with _$OnboardingRealExampleState {
  const OnboardingRealExampleState._();

  factory OnboardingRealExampleState.initial() =
      OnboardingRealExampleStateInitial;

  factory OnboardingRealExampleState.recallCardRevealed(
    bool hasActiveSession,
  ) = OnboardingRealExampleStateRecallCardRevealed;

  /// True when the user has revealed the recall card (matches the `recallCardRevealed` variant).
  bool get recallCardRevealed =>
      whenOrNull(recallCardRevealed: (_) => true) ?? false;
}
