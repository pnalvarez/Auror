import 'package:auror/layers/domain/usecases/select_subscription.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  test('forwards id to repository', () async {
    final repo = MockISubscriptionRepository();
    final sut = SelectSubscription(repo);
    when(repo.selectSubscription(id: anyNamed('id'))).thenAnswer((_) async {});

    await sut.call(id: 'plan-1');

    verify(repo.selectSubscription(id: 'plan-1')).called(1);
  });
}
