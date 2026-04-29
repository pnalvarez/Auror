import 'package:auror/layers/data/datasource/api_data_source.dart';
import 'package:auror/layers/domain/models/subscription_domain.dart';
import 'package:auror/layers/domain/repository/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ISubscriptionRepository)
class SubscriptionRepository implements ISubscriptionRepository {
  final IApiDataSource _apiDataSource;

  SubscriptionRepository(this._apiDataSource);

  @override
  Future<List<SubscriptionDomain>> getSubscriptions() async {
    final subscriptionData = await _apiDataSource.fetchSubscriptions();
    return subscriptionData.map((data) => data.toDomain()).toList();
  }

  @override
  Future<void> selectSubscription({required String id}) async =>
      await _apiDataSource.selectSubscription(subscriptionId: id);

  @override
  Future<void> cancelSubscription() async =>
      await _apiDataSource.cancelSubscription();
}
