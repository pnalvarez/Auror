import 'package:auror/layers/data/repository/auth_repository.dart';
import 'package:auror/layers/domain/models/user_domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIAuthDataSource dataSource;
  late AuthRepository sut;

  setUp(() {
    dataSource = MockIAuthDataSource();
    sut = AuthRepository(dataSource);
  });

  test('currentUser returns null when data source has no user', () {
    when(dataSource.currentUser).thenReturn(null);
    expect(sut.currentUser, isNull);
  });

  test('hasActiveSession forwards data source', () {
    when(dataSource.hasActiveSession).thenReturn(true);
    expect(sut.hasActiveSession, isTrue);
    verify(dataSource.hasActiveSession).called(1);
  });

  test('currentUser maps Supabase user to UserDomain', () {
    final mockUser = MockUser();
    when(mockUser.email).thenReturn('u@example.com');
    when(mockUser.id).thenReturn('uid-1');
    when(mockUser.userMetadata).thenReturn(<String, dynamic>{
      'display_name': 'Display',
    });
    when(dataSource.currentUser).thenReturn(mockUser);

    final u = sut.currentUser!;
    expect(u.email, 'u@example.com');
    expect(u.name, 'Display');
    expect(u.profileImage, '');
    expect(u.username, 'uid-1');
  });

  test('signIn delegates to data source', () async {
    when(
      dataSource.signIn(email: anyNamed('email'), password: anyNamed('password')),
    ).thenAnswer((_) async {});

    await sut.signIn(email: 'e@e.com', password: 'pw');

    verify(dataSource.signIn(email: 'e@e.com', password: 'pw')).called(1);
  });

  test('signUp delegates to data source', () async {
    when(
      dataSource.signUp(
        email: anyNamed('email'),
        password: anyNamed('password'),
        displayName: anyNamed('displayName'),
      ),
    ).thenAnswer((_) async {});

    await sut.signUp(
      email: 'e@e.com',
      password: 'pw',
      displayName: 'Name',
    );

    verify(
      dataSource.signUp(
        email: 'e@e.com',
        password: 'pw',
        displayName: 'Name',
      ),
    ).called(1);
  });

  test('signOut delegates to data source', () async {
    when(dataSource.signOut()).thenAnswer((_) async {});
    await sut.signOut();
    verify(dataSource.signOut()).called(1);
  });
}
