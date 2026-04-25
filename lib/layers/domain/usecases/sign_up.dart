import 'package:auror/layers/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ISignUp {
  Future<void> call({
    required String email,
    required String password,
    required String displayName,
  });
}

@Injectable(as: ISignUp)
class SignUp implements ISignUp {
  final IAuthRepository _repository;

  SignUp(this._repository);

  @override
  Future<void> call({
    required String email,
    required String password,
    required String displayName,
  }) async {
    await _repository.signUp(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
