import 'package:auror/layers/domain/models/idea_domain.dart';
import 'package:auror/layers/domain/models/legacy_knowledge_card_domain.dart';
import 'package:auror/layers/domain/models/revision_domain.dart';
import 'package:auror/layers/domain/models/revision_section_domain.dart';
import 'package:auror/layers/domain/models/user_domain.dart';
import 'package:auror/layers/presentation/screens/home/home_state.dart';
import 'package:auror/layers/presentation/screens/home/home_event.dart';
import 'package:auror/layers/presentation/screens/home/home_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fixtures.dart';
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
        (_) async =>
            RevisionSectionDomain(tomorrowCount: 0, revisions: const []),
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

  blocTest<HomeViewModel, HomeState>(
    'Started maps revisions and idea track on success',
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
          revisions: [
            RevisionDomain(
              id: 'rev-1',
              title: 'Revision title',
              question: 'Question?',
              videoUrl: 'https://example.com/v.mp4',
              category: 'Cat',
              minutes: 12,
              correctAnswer: 'Answer text',
              cardId: 'c1',
            ),
          ],
        ),
      );
      when(getDailyIdea()).thenAnswer(
        (_) async => IdeaDomain(
          completedCards: const [kFixtureKnowledgeCard],
          incompleteCards: const [
            kFixtureKnowledgeCard,
            LegacyKnowledgeCardDomain(
              id: 'c2',
              category: 'Cat',
              title: 'T2',
              quote: 'Q',
              description: 'D',
              videoUrl: 'v',
              practicalExample: 'P',
              commonError: 'E',
            ),
            LegacyKnowledgeCardDomain(
              id: 'c3',
              category: 'Cat',
              title: 'T3',
              quote: 'Q',
              description: 'D',
              videoUrl: 'v',
              practicalExample: 'P',
              commonError: 'E',
            ),
            LegacyKnowledgeCardDomain(
              id: 'c4',
              category: 'Cat',
              title: 'T4',
              quote: 'Q',
              description: 'D',
              videoUrl: 'v',
              practicalExample: 'P',
              commonError: 'E',
            ),
          ],
          totalTime: 30,
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
      expect(bloc.state.revisions.first.time, '12 min');
      expect(bloc.state.dailyIdeaTrackCards, hasLength(3));
      expect(bloc.state.totalRevisionTime, 12);
    },
  );

  blocTest<HomeViewModel, HomeState>(
    'Started clears loading on error',
    build: () {
      when(getUser()).thenThrow(Exception('x'));
      return HomeViewModel(
        getUser: getUser,
        getRevisions: getRevisions,
        getDailyIdea: getDailyIdea,
      );
    },
    act: (bloc) => bloc.add(const Started()),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
    },
  );
}
