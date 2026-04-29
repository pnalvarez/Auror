import 'package:auror/layers/domain/repository/subscription_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ICancelSubscription {
  Future<void> call();
}

@Injectable(as: ICancelSubscription)
class CancelSubscription implements ICancelSubscription {
  CancelSubscription(this._repository);

  final ISubscriptionRepository _repository;

  @override
  Future<void> call() async {
    await _repository.cancelSubscription();
  }
}
