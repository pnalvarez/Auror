import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_state.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_event.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_factory_args.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late MockISendAnswer sendAnswer;
  late MockIGetCardRevision getCardRevision;

  setUp(() {
    sendAnswer = MockISendAnswer();
    getCardRevision = MockIGetCardRevision();
  });

  blocTest<RevisionQuizViewModel, RevisionQuizState>(
    'started loads revision when cardId is set',
    build: () {
      when(
        getCardRevision(cardId: anyNamed('cardId')),
      ).thenAnswer((_) async => kFixtureRevision(cardId: 'x'));
      return RevisionQuizViewModel(
        sendAnswer,
        getCardRevision,
        revisions: const [],
        extras: const RevisionQuizFactoryArgs(cardId: 'x'),
      );
    },
    act: (bloc) => bloc.add(const RevisionQuizEvent.started()),
    wait: const Duration(seconds: 2),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.allRevisions, hasLength(1));
      verify(getCardRevision(cardId: 'x')).called(1);
    },
  );

  blocTest<RevisionQuizViewModel, RevisionQuizState>(
    'answerSent forwards trimmed controller text',
    build: () {
      when(
        sendAnswer(
          answer: anyNamed('answer'),
          revisionId: anyNamed('revisionId'),
        ),
      ).thenAnswer((_) async {});
      final rev = kFixtureRevision(id: 'rid-1');
      return RevisionQuizViewModel(
        sendAnswer,
        getCardRevision,
        revisions: [rev],
        extras: null,
      );
    },
    act: (bloc) {
      bloc.answerDraftController.text = '  my answer  ';
      bloc.add(const RevisionQuizEvent.answerSent('ignored'));
    },
    verify: (_) {
      verify(
        sendAnswer(answer: 'my answer', revisionId: 'rid-1'),
      ).called(1);
    },
  );

  blocTest<RevisionQuizViewModel, RevisionQuizState>(
    'answer draft and deep mode events update CTA flags',
    build: () {
      final rev = kFixtureRevision(id: 'rid-1');
      return RevisionQuizViewModel(
        sendAnswer,
        getCardRevision,
        revisions: [rev],
        extras: null,
      );
    },
    act: (bloc) {
      bloc.add(const RevisionQuizEvent.answerDraftChanged('hello'));
      bloc.add(const RevisionQuizEvent.deepModeToggled());
      bloc.add(const RevisionQuizEvent.revealAnswer());
      bloc.add(const RevisionQuizEvent.clearAnswerDraft());
    },
    verify: (bloc) {
      expect(bloc.state.isSendAnswerCTAEnabled, isFalse);
      expect(bloc.state.answerRevealed, isTrue);
      expect(bloc.answerDraftController.text, isEmpty);
    },
  );

  blocTest<RevisionQuizViewModel, RevisionQuizState>(
    'advance after feedback moves to next revision then pops',
    build: () {
      final r1 = kFixtureRevision(id: 'r1');
      final r2 = kFixtureRevision(id: 'r2');
      return RevisionQuizViewModel(
        sendAnswer,
        getCardRevision,
        revisions: [r1, r2],
        extras: null,
      );
    },
    act: (bloc) {
      bloc.add(const RevisionQuizEvent.advanceAfterFeedback());
      bloc.add(const RevisionQuizEvent.advanceAfterFeedback());
      bloc.add(const RevisionQuizEvent.shouldPopConsumed());
    },
    verify: (bloc) {
      expect(bloc.state.currentIndex, 1);
      expect(bloc.state.shouldPopRoute, isFalse);
    },
  );

  blocTest<RevisionQuizViewModel, RevisionQuizState>(
    'started handles getCardRevision failure',
    build: () {
      when(getCardRevision(cardId: anyNamed('cardId')))
          .thenThrow(Exception('missing'));
      return RevisionQuizViewModel(
        sendAnswer,
        getCardRevision,
        revisions: const [],
        extras: const RevisionQuizFactoryArgs(cardId: 'missing'),
      );
    },
    act: (bloc) => bloc.add(const RevisionQuizEvent.started()),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.allRevisions, isEmpty);
    },
  );
}
