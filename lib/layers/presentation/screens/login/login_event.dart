import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.freezed.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.loginContextChanged(LoginContext loginContext) =
      LoginContextChanged;

  const factory LoginEvent.nameChanged(String value) = LoginNameChanged;

  const factory LoginEvent.emailChanged(String value) = LoginEmailChanged;

  const factory LoginEvent.passwordChanged(String value) = LoginPasswordChanged;

  const factory LoginEvent.confirmPasswordChanged(String value) =
      LoginConfirmPasswordChanged;

  const factory LoginEvent.passwordVisibilityToggled() =
      LoginPasswordVisibilityToggled;

  const factory LoginEvent.confirmPasswordVisibilityToggled() =
      LoginConfirmPasswordVisibilityToggled;

  const factory LoginEvent.submitTapped() = LoginSubmitTapped;

  const factory LoginEvent.dashboardNavigationConsumed() =
      LoginDashboardNavigationConsumed;
}
