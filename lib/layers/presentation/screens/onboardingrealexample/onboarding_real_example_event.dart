import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_real_example_event.freezed.dart';

@freezed
sealed class OnboardingRealExampleEvent with _$OnboardingRealExampleEvent {
  const factory OnboardingRealExampleEvent.started() =
      OnboardingRealExampleStarted;
  const factory OnboardingRealExampleEvent.recallCardRevealed() =
      OnboardingRealExampleRecallCardRevealed;
}
