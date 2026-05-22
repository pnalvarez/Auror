import 'package:auror/layers/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  test('delegates to auth repository', () async {
    final repo = MockIAuthRepository();
    final sut = SignUp(repo);
    when(
      repo.signUp(
        email: anyNamed('email'),
        password: anyNamed('password'),
        displayName: anyNamed('displayName'),
      ),
    ).thenAnswer((_) async {});

    await sut.call(
      email: 'a@b.com',
      password: 'Secret1!',
      displayName: 'Alice',
    );

    verify(
      repo.signUp(
        email: 'a@b.com',
        password: 'Secret1!',
        displayName: 'Alice',
      ),
    ).called(1);
  });
}
