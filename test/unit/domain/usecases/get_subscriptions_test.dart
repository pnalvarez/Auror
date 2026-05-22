import 'package:auror/layers/domain/usecases/get_subscriptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/fixtures.dart';
import '../../../helpers/mocks.mocks.dart';

void main() {
  test('returns repository list', () async {
    final repo = MockISubscriptionRepository();
    final sut = GetSubscriptions(repo);
    final list = [kFixtureSubscriptionDomain(price: 1)];
    when(repo.getSubscriptions()).thenAnswer((_) async => list);

    expect(await sut.call(), same(list));
    verify(repo.getSubscriptions()).called(1);
  });
}
