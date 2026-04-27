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
  Future<void> signIn({required String email, required String password}) =>
      _authService.signIn(email: email, password: password);

  @override
  Future<void> signOut() => _authService.signOut();
}
