import 'package:auror/layers/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ISignIn {
  Future<void> call({required String email, required String password});
}

@Injectable(as: ISignIn)
class SignIn implements ISignIn {
  final IAuthRepository _repository;

  SignIn(this._repository);

  @override
  Future<void> call({required String email, required String password}) async {
    await _repository.signIn(email: email, password: password);
  }
}
