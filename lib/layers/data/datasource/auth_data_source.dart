import 'package:auror/layers/data/client/auth_client.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSourceException implements Exception {
  final String operation;
  final Object cause;

  const AuthDataSourceException({required this.operation, required this.cause});

  @override
  String toString() => 'AuthDataSourceException($operation): $cause';
}

class AuthEmailConfirmationRequiredException extends AuthDataSourceException {
  const AuthEmailConfirmationRequiredException({
    required super.operation,
    required super.cause,
  });
}

abstract class IAuthDataSource {
  User? get currentUser;

  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();
}

@Injectable(as: IAuthDataSource)
class AuthDataSource implements IAuthDataSource {
  final IAuthService _authService;

  AuthDataSource(this._authService);

  @override
  User? get currentUser => _authService.currentUser;

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      await _authService.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
    } catch (exception) {
      throw AuthDataSourceException(operation: 'signUp', cause: exception);
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _authService.signIn(email: email, password: password);
    } on AuthException catch (exception) {
      if (_requiresEmailConfirmation(exception)) {
        throw AuthEmailConfirmationRequiredException(
          operation: 'signIn',
          cause: exception,
        );
      }
      throw AuthDataSourceException(operation: 'signIn', cause: exception);
    } catch (exception) {
      throw AuthDataSourceException(operation: 'signIn', cause: exception);
    }
  }

  @override
  Future<void> signOut() => _authService.signOut();

  bool _requiresEmailConfirmation(AuthException exception) {
    final code = exception.code;
    final message = exception.message.toLowerCase();
    return code == 'email_not_confirmed' ||
        code == 'phone_not_confirmed' ||
        message.contains('email not confirmed');
  }
}
