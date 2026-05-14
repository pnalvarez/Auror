import 'package:auror/layers/data/datasource/auth_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gotrue/gotrue.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIAuthService authService;
  late AuthDataSource sut;

  setUp(() {
    authService = MockIAuthService();
    sut = AuthDataSource(authService);
  });

  test('currentUser forwards auth service', () {
    when(authService.currentUser).thenReturn(null);
    expect(sut.currentUser, isNull);
    verify(authService.currentUser).called(1);
  });

  test('signUp wraps generic errors in AuthDataSourceException', () async {
    when(
      authService.signUp(
        email: anyNamed('email'),
        password: anyNamed('password'),
        displayName: anyNamed('displayName'),
      ),
    ).thenThrow(Exception('network'));

    await expectLater(
      sut.signUp(email: 'a@b.com', password: 'p', displayName: 'N'),
      throwsA(
        isA<AuthDataSourceException>().having(
          (e) => e.operation,
          'operation',
          'signUp',
        ),
      ),
    );
  });

  test('signIn maps email_not_confirmed to AuthEmailConfirmationRequiredException',
      () async {
    when(
      authService.signIn(email: anyNamed('email'), password: anyNamed('password')),
    ).thenThrow(
      const AuthException('confirm', code: 'email_not_confirmed'),
    );

    await expectLater(
      sut.signIn(email: 'a@b.com', password: 'p'),
      throwsA(isA<AuthEmailConfirmationRequiredException>()),
    );
  });

  test('signIn wraps other AuthException in AuthDataSourceException', () async {
    when(
      authService.signIn(email: anyNamed('email'), password: anyNamed('password')),
    ).thenThrow(const AuthException('bad creds', code: 'invalid_credentials'));

    await expectLater(
      sut.signIn(email: 'a@b.com', password: 'p'),
      throwsA(
        isA<AuthDataSourceException>().having(
          (e) => e.operation,
          'operation',
          'signIn',
        ),
      ),
    );
  });

  test('signOut delegates to auth service', () async {
    when(authService.signOut()).thenAnswer((_) async {});
    await sut.signOut();
    verify(authService.signOut()).called(1);
  });
}
