import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:auror/layers/presentation/screens/login/login_validators.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    required LoginContext loginContext,
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(true) bool obscurePassword,
    @Default(true) bool obscureConfirm,
    @Default(false) bool pendingDashboardNavigation,
    @Default(null) String? errorMessage,
    @Default(null) String? snackBarMessage,
    @Default(false) bool isLoading,
  }) = _LoginState;
}

extension LoginStateValidation on LoginState {
  bool get isSignUp => loginContext == LoginContext.signUp;

  bool _passwordValidForContext(String value) {
    if (isSignUp) {
      return meetsSignUpPasswordRules(value);
    }
    return value.trim().isNotEmpty;
  }

  bool get canSubmit {
    if (!isValidEmailFormat(email)) return false;
    if (!_passwordValidForContext(password)) return false;
    if (isSignUp) {
      if (name.trim().isEmpty) return false;
      if (confirmPassword != password) return false;
    }
    return true;
  }
}
