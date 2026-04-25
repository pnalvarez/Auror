import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IAuthService {
  User? get currentUser;

  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();
}

@Injectable(as: IAuthService)
class AuthService implements IAuthService {
  SupabaseClient get _client => Supabase.instance.client;

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    await _client.auth.signUp(
      email: email,
      password: password,
      data: {'display_name': displayName},
    );
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() => _client.auth.signOut();
}
