import 'dart:async';
import 'dart:io';

import 'package:auror/common/strings/login_auth_strings.dart';
import 'package:auror/layers/data/datasource/auth_data_source.dart';
import 'package:auror/layers/presentation/screens/login/login_auth_error_mapper.dart';
import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gotrue/gotrue.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  group('mapLoginAuthErrorToPortuguese', () {
    test('unwraps AuthDataSourceException chain', () {
      const inner = AuthException('bad', code: 'invalid_credentials');
      const wrapped = AuthDataSourceException(operation: 'signIn', cause: inner);

      expect(
        mapLoginAuthErrorToPortuguese(wrapped, loginContext: LoginContext.signIn),
        loginAuthErrorInvalidCredentials,
      );
    });

    test('maps network errors', () {
      expect(
        mapLoginAuthErrorToPortuguese(
          const SocketException('offline'),
          loginContext: LoginContext.signIn,
        ),
        loginAuthErrorNetwork,
      );
      expect(
        mapLoginAuthErrorToPortuguese(
          TimeoutException('t'),
          loginContext: LoginContext.signIn,
        ),
        loginAuthErrorNetwork,
      );
    });

    test('maps AuthException codes', () {
      expect(
        mapLoginAuthErrorToPortuguese(
          const AuthException('x', code: 'email_exists'),
          loginContext: LoginContext.signUp,
        ),
        loginAuthErrorEmailExists,
      );
      expect(
        mapLoginAuthErrorToPortuguese(
          const AuthException('x', code: 'email_not_confirmed'),
          loginContext: LoginContext.signIn,
        ),
        loginAuthErrorEmailNotConfirmed,
      );
      expect(
        mapLoginAuthErrorToPortuguese(
          const AuthException('x', code: 'email_not_confirmed'),
          loginContext: LoginContext.signUp,
        ),
        loginAuthErrorSignUpConfirmEmail,
      );
      expect(
        mapLoginAuthErrorToPortuguese(
          const AuthDataSourceException(
            operation: 'signInAfterSignUp',
            cause: AuthException('x', code: 'email_not_confirmed'),
          ),
          loginContext: LoginContext.signUp,
        ),
        loginAuthErrorSignUpConfirmEmail,
      );
      expect(
        mapLoginAuthErrorToPortuguese(
          const AuthException('x', code: 'weak_password'),
          loginContext: LoginContext.signUp,
        ),
        loginAuthErrorWeakPassword,
      );
      expect(
        mapLoginAuthErrorToPortuguese(
          AuthWeakPasswordException(
            message: 'weak',
            statusCode: '422',
            reasons: ['length'],
          ),
          loginContext: LoginContext.signUp,
        ),
        contains(loginAuthErrorWeakPassword),
      );
      expect(
        mapLoginAuthErrorToPortuguese(
          const AuthException('invalid login credentials', code: 'other'),
          loginContext: LoginContext.signIn,
        ),
        loginAuthErrorInvalidCredentials,
      );
      expect(
        mapLoginAuthErrorToPortuguese(
          const AuthException('path', code: 'x', statusCode: '404'),
          loginContext: LoginContext.signIn,
        ),
        loginAuthErrorServerConfig,
      );
      expect(
        mapLoginAuthErrorToPortuguese(
          Exception('unknown'),
          loginContext: LoginContext.signIn,
        ),
        loginAuthErrorUnknown,
      );
    });
  });

  group('mapSignOutAuthErrorToPortuguese', () {
    test('maps session and rate limit codes', () {
      expect(
        mapSignOutAuthErrorToPortuguese(
          const AuthException('x', code: 'session_not_found'),
        ),
        loginAuthErrorSignOutSession,
      );
      expect(
        mapSignOutAuthErrorToPortuguese(
          const AuthException('x', code: 'over_request_rate_limit'),
        ),
        loginAuthErrorRateLimit,
      );
      expect(
        mapSignOutAuthErrorToPortuguese(const SocketException('x')),
        loginAuthErrorNetwork,
      );
      expect(
        mapSignOutAuthErrorToPortuguese(Exception('x')),
        loginAuthErrorSignOutFailed,
      );
    });
  });
}
