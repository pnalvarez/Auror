import 'package:auror/layers/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ISignOut {
  Future<void> call();
}

@Injectable(as: ISignOut)
class SignOut implements ISignOut {
  final IAuthRepository _repository;

  SignOut(this._repository);

  @override
  Future<void> call() async {
    await _repository.signOut();
  }
}
