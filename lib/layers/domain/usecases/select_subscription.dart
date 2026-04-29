import 'package:auror/layers/domain/repository/subscription_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ISelectSubscription {
  Future<void> call({required String id});
}

@Injectable(as: ISelectSubscription)
class SelectSubscription implements ISelectSubscription {
  SelectSubscription(this._repository);

  final ISubscriptionRepository _repository;

  @override
  Future<void> call({required String id}) async {
    await _repository.selectSubscription(id: id);
  }
}
