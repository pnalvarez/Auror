import 'package:auror/layers/domain/models/subscription_domain.dart';
import 'package:auror/layers/domain/repository/subscription_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IGetSubscriptions {
  Future<List<SubscriptionDomain>> call();
}

@Injectable(as: IGetSubscriptions)
class GetSubscriptions implements IGetSubscriptions {
  GetSubscriptions(this._repository);

  final ISubscriptionRepository _repository;

  @override
  Future<List<SubscriptionDomain>> call() async {
    return await _repository.getSubscriptions();
  }
}
