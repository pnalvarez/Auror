import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:auror/layers/presentation/screens/login/login_event.dart';
import 'package:auror/layers/presentation/screens/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  LoginViewModel({required LoginContext loginContext})
    : super(LoginState(loginContext: loginContext)) {
    on<LoginNameChanged>(_onNameChanged);
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<LoginPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<LoginConfirmPasswordVisibilityToggled>(
      _onConfirmPasswordVisibilityToggled,
    );
    on<LoginSubmitTapped>(_onSubmitTapped);
    on<LoginDashboardNavigationConsumed>(_onDashboardNavigationConsumed);
    on<LoginContextChanged>(_onLoginContextChanged);
  }

  void _onLoginContextChanged(
    LoginContextChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        loginContext: event.loginContext,
        name: '',
        confirmPassword: '',
        obscureConfirm: true,
        pendingDashboardNavigation: false,
      ),
    );
  }

  void _onNameChanged(LoginNameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(name: event.value));
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.value));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.value));
  }

  void _onConfirmPasswordChanged(
    LoginConfirmPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(confirmPassword: event.value));
  }

  void _onPasswordVisibilityToggled(
    LoginPasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onConfirmPasswordVisibilityToggled(
    LoginConfirmPasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(obscureConfirm: !state.obscureConfirm));
  }

  void _onSubmitTapped(LoginSubmitTapped event, Emitter<LoginState> emit) {
    if (!state.canSubmit) return;
    // TODO: wire auth repository / session.
    emit(state.copyWith(pendingDashboardNavigation: true));
  }

  void _onDashboardNavigationConsumed(
    LoginDashboardNavigationConsumed event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(pendingDashboardNavigation: false));
  }
}
