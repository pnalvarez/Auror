import 'package:auror/layers/domain/usecases/has_active_session.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_event.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainLaunchViewModel extends Bloc<MainLaunchEvent, MainLaunchState> {
  MainLaunchViewModel(this._hasActiveSession)
    : super(const MainLaunchState.initial()) {
    on<MainLaunchStarted>(_onStarted);
    on<MainLaunchEnterAppTapped>(_onEnterAppTapped);
    on<MainLaunchHowItWorksTapped>(_onHowItWorksTapped);
    on<MainLaunchDashboardNavigationConsumed>(_onDashboardNavigationConsumed);
  }

  final IHasActiveSession _hasActiveSession;

  Future<void> _onStarted(
    MainLaunchStarted event,
    Emitter<MainLaunchState> emit,
  ) async {
    emit(const MainLaunchState.loading());
    final hasSession = _hasActiveSession();
    emit(
      MainLaunchState.ready(
        hasActiveSession: hasSession,
        pendingDashboardNavigation: hasSession,
      ),
    );
  }

  void _onEnterAppTapped(
    MainLaunchEnterAppTapped event,
    Emitter<MainLaunchState> emit,
  ) {
    final current = state;
    if (current is! MainLaunchStateReady || !current.hasActiveSession) {
      return;
    }
    emit(current.copyWith(pendingDashboardNavigation: true));
  }

  void _onHowItWorksTapped(
    MainLaunchHowItWorksTapped event,
    Emitter<MainLaunchState> emit,
  ) {
    // TODO: scroll to section or push product tour route.
  }

  void _onDashboardNavigationConsumed(
    MainLaunchDashboardNavigationConsumed event,
    Emitter<MainLaunchState> emit,
  ) {
    final current = state;
    if (current is! MainLaunchStateReady) return;
    emit(current.copyWith(pendingDashboardNavigation: false));
  }
}
