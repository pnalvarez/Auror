import 'dart:async';
import 'dart:io';

import 'package:auror/common/strings/login_auth_strings.dart';
import 'package:auror/layers/data/datasource/auth_data_source.dart';
import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Converte erros de sign-in / sign-up em texto amigável em português.
String mapLoginAuthErrorToPortuguese(
  Object error, {
  required LoginContext loginContext,
}) {
  var current = error;
  final dataSourceOps = <String>[];
  while (current is AuthDataSourceException) {
    dataSourceOps.add(current.operation);
    current = current.cause;
  }

  if (current is AuthWeakPasswordException) {
    if (current.reasons.isNotEmpty) {
      return '$loginAuthErrorWeakPassword (${current.reasons.join(', ')})';
    }
    return loginAuthErrorWeakPassword;
  }

  if (current is SocketException ||
      current is TimeoutException ||
      current is HandshakeException ||
      current is TlsException) {
    return loginAuthErrorNetwork;
  }

  if (current is AuthException) {
    final code = current.code;
    final status = current.statusCode;
    final msgLower = current.message.toLowerCase();

    switch (code) {
      case 'email_exists':
      case 'user_already_exists':
        return loginAuthErrorEmailExists;
      case 'email_not_confirmed':
      case 'phone_not_confirmed':
        if (dataSourceOps.contains('signInAfterSignUp')) {
          return loginAuthErrorSignUpConfirmEmail;
        }
        return loginContext == LoginContext.signUp
            ? loginAuthErrorSignUpConfirmEmail
            : loginAuthErrorEmailNotConfirmed;
      case 'signup_disabled':
        return loginAuthErrorSignupDisabled;
      case 'user_banned':
        return loginAuthErrorUserBanned;
      case 'over_request_rate_limit':
      case 'over_email_send_rate_limit':
      case 'over_sms_send_rate_limit':
        return loginAuthErrorRateLimit;
      case 'weak_password':
        return loginAuthErrorWeakPassword;
      default:
        break;
    }

    final invalidLogin =
        code == 'invalid_credentials' ||
        code == 'invalid_grant' ||
        msgLower.contains('invalid login');

    if (invalidLogin) {
      return loginAuthErrorInvalidCredentials;
    }

    if (dataSourceOps.contains('signInAfterSignUp')) {
      return loginAuthErrorSignInAfterSignUpGeneric;
    }

    if (status == '404' ||
        msgLower.contains('invalid path') ||
        msgLower.contains('requested path is invalid')) {
      return loginAuthErrorServerConfig;
    }
  }

  return loginAuthErrorUnknown;
}

/// Mensagens em português para falha ao sair (ex.: perfil → Sair).
String mapSignOutAuthErrorToPortuguese(Object error) {
  var current = error;
  while (current is AuthDataSourceException) {
    current = current.cause;
  }

  if (current is SocketException ||
      current is TimeoutException ||
      current is HandshakeException ||
      current is TlsException) {
    return loginAuthErrorNetwork;
  }

  if (current is AuthException) {
    final code = current.code;
    final status = current.statusCode;
    final msgLower = current.message.toLowerCase();

    switch (code) {
      case 'session_not_found':
      case 'bad_jwt':
      case 'invalid_jwt':
        return loginAuthErrorSignOutSession;
      case 'over_request_rate_limit':
      case 'over_email_send_rate_limit':
      case 'over_sms_send_rate_limit':
        return loginAuthErrorRateLimit;
      default:
        break;
    }

    if (status == '404' ||
        msgLower.contains('invalid path') ||
        msgLower.contains('requested path is invalid')) {
      return loginAuthErrorServerConfig;
    }
  }

  return loginAuthErrorSignOutFailed;
}
