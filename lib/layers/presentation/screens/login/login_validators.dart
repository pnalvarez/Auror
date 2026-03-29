import 'package:auror/common/strings/login_strings.dart';

/// Validation helpers for [LoginPage] (email + password rules).
bool isValidEmailFormat(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return false;
  return RegExp(r'^[^\s@]+@([^\s@]+\.)+[^\s@]{2,}$').hasMatch(trimmed);
}

/// Sign-up: ≥8 chars, at least one digit, one uppercase, one special character.
bool meetsSignUpPasswordRules(String password) {
  if (password.length < 8) return false;
  if (!RegExp(r'[0-9]').hasMatch(password)) return false;
  if (!RegExp(r'[A-Z]').hasMatch(password)) return false;
  if (!RegExp(
    r'''[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>/?`~]''',
  ).hasMatch(password)) {
    return false;
  }
  return true;
}

/// Error line under the field: only when there is non-empty text that is still invalid.
String? loginEmailError(String email) {
  if (email.isEmpty) return null;
  if (email.trim().isEmpty) return loginErrorEmailInvalid;
  if (!isValidEmailFormat(email)) return loginErrorEmailInvalid;
  return null;
}

/// Name: non-empty raw string but only whitespace.
String? loginNameError(String name) {
  if (name.isEmpty) return null;
  if (name.trim().isEmpty) return loginErrorNameWhitespace;
  return null;
}

String? loginPasswordError(String password, {required bool isSignUp}) {
  if (password.isEmpty) return null;
  if (isSignUp) {
    if (!meetsSignUpPasswordRules(password)) {
      return loginErrorPasswordRequirements;
    }
    return null;
  }
  if (password.trim().isEmpty) {
    return loginErrorPasswordWhitespace;
  }
  return null;
}

String? loginConfirmPasswordError(String confirm, String password) {
  if (confirm.isEmpty) return null;
  if (confirm != password) return loginErrorPasswordMismatch;
  return null;
}
