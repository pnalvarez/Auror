import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_state.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_event.dart';
import 'package:auror/layers/presentation/screens/onboardingrealexample/onboarding_real_example_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest<OnboardingRealExampleViewModel, OnboardingRealExampleState>(
    'recall card revealed toggles state flag',
    build: OnboardingRealExampleViewModel.new,
    act: (bloc) => bloc.add(const OnboardingRealExampleRecallCardRevealed()),
    verify: (bloc) {
      expect(bloc.state.recallCardRevealed, isTrue);
    },
  );
}
