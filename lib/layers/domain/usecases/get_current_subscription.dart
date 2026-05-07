import 'package:auror/layers/domain/models/subscription_domain.dart';
import 'package:auror/layers/domain/repository/subscription_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IGetCurrentSubscription {
  Future<SubscriptionDomain> call();
}

@Injectable(as: IGetCurrentSubscription)
class GetCurrentSubscription implements IGetCurrentSubscription {
  final ISubscriptionRepository _repository;

  GetCurrentSubscription(this._repository);

  @override
  Future<SubscriptionDomain> call() async =>
      await _repository.getCurrentSubscription();
}
