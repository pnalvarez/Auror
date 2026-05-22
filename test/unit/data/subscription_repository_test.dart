import 'package:auror/layers/data/repository/subscription_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIApiDataSource api;
  late SubscriptionRepository sut;

  setUp(() {
    api = MockIApiDataSource();
    sut = SubscriptionRepository(api);
  });

  test('getSubscriptions maps data to domain list', () async {
    final rows = [
      kFixtureSubscriptionData(price: 10),
      kFixtureSubscriptionData(price: 20),
    ];
    when(api.fetchSubscriptions(resourceName: anyNamed('resourceName')))
        .thenAnswer((_) async => rows);

    final result = await sut.getSubscriptions();

    expect(result, hasLength(2));
    expect(result.first.price, 10);
    expect(result.last.price, 20);
    verify(api.fetchSubscriptions()).called(1);
  });

  test('getCurrentSubscription delegates and maps', () async {
    final row = kFixtureSubscriptionData(isCurrent: true, price: 99);
    when(api.fetchCurrentSubscription(resourceName: anyNamed('resourceName')))
        .thenAnswer((_) async => row);

    final domain = await sut.getCurrentSubscription();

    expect(domain.price, 99);
    expect(domain.isCurrent, isTrue);
  });

  test('selectSubscription forwards id', () async {
    when(
      api.selectSubscription(
        subscriptionId: anyNamed('subscriptionId'),
        rpcName: anyNamed('rpcName'),
      ),
    ).thenAnswer((_) async {});

    await sut.selectSubscription(id: 'abc');

    verify(api.selectSubscription(subscriptionId: 'abc')).called(1);
  });

  test('cancelSubscription delegates', () async {
    when(api.cancelSubscription(rpcName: anyNamed('rpcName')))
        .thenAnswer((_) async {});

    await sut.cancelSubscription();

    verify(api.cancelSubscription()).called(1);
  });
}
