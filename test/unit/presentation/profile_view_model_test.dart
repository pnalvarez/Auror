import 'package:auror/layers/presentation/screens/profile/profile_state.dart';
import 'package:auror/layers/presentation/screens/profile/profile_event.dart';
import 'package:auror/layers/presentation/screens/profile/profile_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIGetProfile getProfile;
  late MockISignOut signOut;
  late MockIGetCurrentSubscription getCurrent;

  setUp(() {
    getProfile = MockIGetProfile();
    signOut = MockISignOut();
    getCurrent = MockIGetCurrentSubscription();
  });

  blocTest<ProfileViewModel, ProfileState>(
    'load requested populates profile UI',
    build: () {
      when(getProfile()).thenAnswer((_) async => kExpectedProfileDomain(kFixtureUser));
      when(getCurrent()).thenAnswer((_) async => kFixtureSubscriptionDomain());
      return ProfileViewModel(getProfile, signOut, getCurrent);
    },
    act: (bloc) => bloc.add(const ProfileLoadRequested()),
    verify: (bloc) {
      expect(bloc.state.isLoadingData, isFalse);
      expect(bloc.state.profile, isNotNull);
      expect(bloc.state.profile!.email, kFixtureUser.email);
      verify(getProfile()).called(1);
      verify(getCurrent()).called(1);
    },
  );

  blocTest<ProfileViewModel, ProfileState>(
    'logout invokes sign out then sets main launch navigation',
    build: () {
      when(signOut()).thenAnswer((_) async {});
      return ProfileViewModel(getProfile, signOut, getCurrent);
    },
    act: (bloc) => bloc.add(const ProfileLogoutTapped()),
    verify: (bloc) {
      verify(signOut()).called(1);
      expect(bloc.state.pendingMainLaunchNavigation, isTrue);
    },
  );
}
