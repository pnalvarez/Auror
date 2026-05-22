import 'package:auror/layers/domain/usecases/get_current_subscription.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/fixtures.dart';
import '../../../helpers/mocks.mocks.dart';

void main() {
  test('returns repository value', () async {
    final repo = MockISubscriptionRepository();
    final sut = GetCurrentSubscription(repo);
    final sub = kFixtureSubscriptionDomain();
    when(repo.getCurrentSubscription()).thenAnswer((_) async => sub);

    expect(await sut.call(), same(sub));
    verify(repo.getCurrentSubscription()).called(1);
  });
}
