import 'package:auror/layers/data/client/auth_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockSupabaseClient supabaseClient;
  late MockGoTrueClient auth;
  late AuthService sut;

  setUp(() {
    supabaseClient = MockSupabaseClient();
    auth = MockGoTrueClient();
    when(supabaseClient.auth).thenReturn(auth);
    sut = AuthService.withClient(supabaseClient);
  });

  test('currentUser forwards Supabase auth', () {
    final user = User(
      id: 'uid',
      appMetadata: const {},
      userMetadata: const {},
      aud: 'authenticated',
      createdAt: DateTime.utc(2024).toIso8601String(),
    );
    when(auth.currentUser).thenReturn(user);

    expect(sut.currentUser, user);
    verify(auth.currentUser).called(1);
  });

  test('signUp delegates to GoTrue', () async {
    when(
      auth.signUp(
        email: anyNamed('email'),
        password: anyNamed('password'),
        data: anyNamed('data'),
      ),
    ).thenAnswer((_) async => AuthResponse());

    await sut.signUp(
      email: 'a@b.com',
      password: 'Secret1!',
      displayName: 'Ada',
    );

    verify(
      auth.signUp(
        email: 'a@b.com',
        password: 'Secret1!',
        data: {'display_name': 'Ada'},
      ),
    ).called(1);
  });

  test('signIn delegates to GoTrue', () async {
    when(
      auth.signInWithPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenAnswer((_) async => AuthResponse());

    await sut.signIn(email: 'a@b.com', password: 'pw');

    verify(
      auth.signInWithPassword(email: 'a@b.com', password: 'pw'),
    ).called(1);
  });

  test('signOut delegates to GoTrue', () async {
    when(auth.signOut()).thenAnswer((_) async {});
    await sut.signOut();
    verify(auth.signOut()).called(1);
  });
}
