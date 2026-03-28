import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_event.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLaunchViewModel extends Bloc<MainLaunchEvent, MainLaunchState> {
  MainLaunchViewModel() : super(const MainLaunchState.initial()) {
    on<MainLaunchStarted>(_onStarted);
    on<MainLaunchEnterAppTapped>(_onEnterAppTapped);
    on<MainLaunchHowItWorksTapped>(_onHowItWorksTapped);
  }

  Future<void> _onStarted(
    MainLaunchStarted event,
    Emitter<MainLaunchState> emit,
  ) async {
    emit(const MainLaunchState.loading());
    // TODO: replace with auth / session repository (e.g. valid refresh token).
    await Future<void>.delayed(const Duration(milliseconds: 400));
    emit(const MainLaunchState.ready(hasActiveSession: false));
  }

  void _onEnterAppTapped(
    MainLaunchEnterAppTapped event,
    Emitter<MainLaunchState> emit,
  ) {
    // TODO: navigate to signed-in home or onboarding / login.
  }

  void _onHowItWorksTapped(
    MainLaunchHowItWorksTapped event,
    Emitter<MainLaunchState> emit,
  ) {
    // TODO: scroll to section or push product tour route.
  }
}
