import 'package:auror/layers/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  test('delegates to auth repository', () async {
    final repo = MockIAuthRepository();
    final sut = SignIn(repo);
    when(
      repo.signIn(email: anyNamed('email'), password: anyNamed('password')),
    ).thenAnswer((_) async {});

    await sut.call(email: 'a@b.com', password: 'secret');

    verify(repo.signIn(email: 'a@b.com', password: 'secret')).called(1);
  });
}
