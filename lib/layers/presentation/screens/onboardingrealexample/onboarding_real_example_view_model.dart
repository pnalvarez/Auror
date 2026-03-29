import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_event.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingRealExampleViewModel
    extends Bloc<OnboardingRealExampleEvent, OnboardingRealExampleState> {
  OnboardingRealExampleViewModel()
    : super(OnboardingRealExampleState.initial()) {
    on<OnboardingRealExampleStarted>((event, emit) {
      emit(OnboardingRealExampleState.initial());
    });
    on<OnboardingRealExampleRecallCardRevealed>((event, emit) {
      emit(OnboardingRealExampleState.recallCardRevealed(true));
    });
  }
}
