import 'package:auror/layers/data/repository/profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIApiDataSource api;
  late MockIAuthRepository auth;
  late ProfileRepository sut;

  setUp(() {
    api = MockIApiDataSource();
    auth = MockIAuthRepository();
    sut = ProfileRepository(api, auth);
  });

  test('getProfile throws when not authenticated', () async {
    when(auth.currentUser).thenReturn(null);

    expect(sut.getProfile, throwsStateError);
    verifyNever(
      api.fetchProfile(userId: anyNamed('userId')),
    );
  });

  test('getProfile returns mapped domain when authenticated', () async {
    when(auth.currentUser).thenReturn(kFixtureUser);
    when(api.fetchProfile(userId: kFixtureUser.username)).thenAnswer(
      (_) async => kFixtureProfileData,
    );

    final result = await sut.getProfile();
    final expected = kExpectedProfileDomain(kFixtureUser);
    expect(result.username, expected.username);
    expect(result.email, expected.email);
    expect(result.profileImage, expected.profileImage);
    expect(result.learnedCards, expected.learnedCards);
    expect(result.revisionsDone, expected.revisionsDone);
    expect(result.followedDays, expected.followedDays);
    expect(result.isSubscribed, expected.isSubscribed);
    verify(api.fetchProfile(userId: kFixtureUser.username)).called(1);
  });

  test('getProfile uses email local-part as username when name empty', () async {
    when(auth.currentUser).thenReturn(kFixtureUserEmailOnly);
    when(api.fetchProfile(userId: kFixtureUserEmailOnly.username)).thenAnswer(
      (_) async => kFixtureProfileData,
    );

    final result = await sut.getProfile();

    expect(result.username, 'learner');
    expect(result.email, kFixtureUserEmailOnly.email);
  });
}
