import 'package:auror/layers/domain/models/idea_domain.dart';
import 'package:auror/layers/domain/models/revision_section_domain.dart';
import 'package:auror/layers/domain/models/user_domain.dart';
import 'package:auror/layers/presentation/screens/home/home_state.dart';
import 'package:auror/layers/presentation/screens/home/home_event.dart';
import 'package:auror/layers/presentation/screens/home/home_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIGetUser getUser;
  late MockIGetRevisions getRevisions;
  late MockIGetDailyIdea getDailyIdea;

  setUp(() {
    getUser = MockIGetUser();
    getRevisions = MockIGetRevisions();
    getDailyIdea = MockIGetDailyIdea();
  });

  blocTest<HomeViewModel, HomeState>(
    'Started loads user, revisions, and daily idea',
    build: () {
      when(getUser()).thenAnswer(
        (_) async => const UserDomain(
          username: 'u',
          name: 'N',
          email: 'e@e.com',
          profileImage: '',
        ),
      );
      when(getRevisions()).thenAnswer(
        (_) async => RevisionSectionDomain(
          tomorrowCount: 0,
          revisions: const [],
        ),
      );
      when(getDailyIdea()).thenAnswer(
        (_) async => const IdeaDomain(
          completedCards: [],
          incompleteCards: [],
          totalTime: 0,
        ),
      );
      return HomeViewModel(
        getUser: getUser,
        getRevisions: getRevisions,
        getDailyIdea: getDailyIdea,
      );
    },
    act: (bloc) => bloc.add(const Started()),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.userName, 'N');
      verify(getUser()).called(1);
      verify(getRevisions()).called(1);
      verify(getDailyIdea()).called(1);
    },
  );
}
