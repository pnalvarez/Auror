import 'package:auror/layers/domain/usecases/sign_out.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  test('delegates to auth repository', () async {
    final repo = MockIAuthRepository();
    final sut = SignOut(repo);
    when(repo.signOut()).thenAnswer((_) async {});

    await sut.call();

    verify(repo.signOut()).called(1);
  });
}
