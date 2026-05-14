import 'package:auror/layers/domain/usecases/cancel_subscription.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  test('delegates to repository', () async {
    final repo = MockISubscriptionRepository();
    final sut = CancelSubscription(repo);
    when(repo.cancelSubscription()).thenAnswer((_) async {});

    await sut.call();

    verify(repo.cancelSubscription()).called(1);
  });
}
