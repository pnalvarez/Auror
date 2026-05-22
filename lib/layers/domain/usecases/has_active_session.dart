import 'package:auror/layers/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IHasActiveSession {
  bool call();
}

@Injectable(as: IHasActiveSession)
class HasActiveSession implements IHasActiveSession {
  final IAuthRepository _repository;

  HasActiveSession(this._repository);

  @override
  bool call() => _repository.hasActiveSession;
}
