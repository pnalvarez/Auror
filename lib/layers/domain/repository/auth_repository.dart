import 'package:auror/layers/domain/models/user_domain.dart';

abstract class IAuthRepository {
  UserDomain? get currentUser;
  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();
}
