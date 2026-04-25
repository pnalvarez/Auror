import 'package:auror/layers/domain/usecases/sign_in.dart';
import 'package:auror/layers/domain/usecases/sign_out.dart';
import 'package:auror/layers/domain/usecases/sign_up.dart';
import 'package:auror/layers/presentation/screens/login/login_auth_error_mapper.dart';
import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:auror/layers/presentation/screens/login/login_event.dart';
import 'package:auror/layers/presentation/screens/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final ISignIn _signIn;
  final ISignOut _signOut;
  final ISignUp _signUp;

  LoginViewModel(
    @factoryParam LoginContext loginContext,
    this._signIn,
    this._signOut,
    this._signUp,
  ) : super(LoginState(loginContext: loginContext)) {
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
    on<LoginSnackBarConsumed>(_onSnackBarConsumed);
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
        snackBarMessage: null,
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

  Future<void> _onSubmitTapped(
    LoginSubmitTapped event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.canSubmit) return;
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        snackBarMessage: null,
      ),
    );
    try {
      switch (state.loginContext) {
        case LoginContext.signIn:
          await _signIn(email: state.email, password: state.password);
          break;
        case LoginContext.signUp:
          await _signUp(
            email: state.email,
            password: state.password,
            displayName: state.name,
          );
          break;
      }
      emit(
        state.copyWith(
          isLoading: false,
          pendingDashboardNavigation: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          snackBarMessage: mapLoginAuthErrorToPortuguese(
            e,
            loginContext: state.loginContext,
          ),
        ),
      );
    }
  }

  void _onSnackBarConsumed(
    LoginSnackBarConsumed event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(snackBarMessage: null));
  }

  void _onDashboardNavigationConsumed(
    LoginDashboardNavigationConsumed event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(pendingDashboardNavigation: false));
  }
}
