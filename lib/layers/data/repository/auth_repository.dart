import 'package:auror/layers/data/datasource/auth_data_source.dart';
import 'package:auror/layers/domain/models/user_domain.dart';
import 'package:auror/layers/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final IAuthDataSource _dataSource;

  AuthRepository(this._dataSource);

  @override
  UserDomain? get currentUser {
    final user = _dataSource.currentUser;
    if (user == null) return null;
    return UserDomain(
      email: user.email ?? '',
      name: user.userMetadata?['display_name'] ?? '',
      profileImage: '',
      username: user.id,
    );
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async => await _dataSource.signUp(
    email: email,
    password: password,
    displayName: displayName,
  );

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async => await _dataSource.signIn(email: email, password: password);

  @override
  Future<void> signOut() async => await _dataSource.signOut();
}
