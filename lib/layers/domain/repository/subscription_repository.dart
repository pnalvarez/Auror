import 'package:auror/layers/domain/models/subscription_domain.dart';

abstract class ISubscriptionRepository {
  Future<List<SubscriptionDomain>> getSubscriptions();
}
