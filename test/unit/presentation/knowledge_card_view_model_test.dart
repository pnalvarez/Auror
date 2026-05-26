import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_event.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_state.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_ui.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

const _quiz = QuizUI(
  question: 'Pergunta?',
  option1: 'A',
  option2: 'B',
  option3: 'C',
  option4: 'D',
  correctAnswer: 1,
);

const _card = KnowledgeCardUI(
  title: 'Mesopotâmia',
  description: 'Descrição.',
  curiosity: 'Curiosidade.',
  commonError: 'Erro comum.',
  quiz: _quiz,
);

const _twoCards = [_card, _card];

void main() {
  blocTest<KnowledgeCardViewModel, KnowledgeCardState>(
    'starts with initial state',
    build: KnowledgeCardViewModel.new,
    verify: (bloc) {
      expect(bloc.state, KnowledgeCardState.initial);
    },
  );

  blocTest<KnowledgeCardViewModel, KnowledgeCardState>(
    'load requested ends in loaded state',
    build: KnowledgeCardViewModel.new,
    act: (bloc) => bloc.add(const KnowledgeCardEvent.loadRequested()),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.errorMessage, isNull);
    },
  );

  blocTest<KnowledgeCardViewModel, KnowledgeCardState>(
    'did click curiosity expands section and shows common error tooltip',
    build: KnowledgeCardViewModel.new,
    act: (bloc) => bloc.add(const KnowledgeCardEvent.didClickCuriosity()),
    verify: (bloc) {
      expect(bloc.state.isCuriosityExpanded, isTrue);
      expect(bloc.state.shouldDisplayCuriosityTooltip, isFalse);
      expect(bloc.state.shouldDisplayCommonErrorTooltip, isTrue);
      expect(bloc.state.isNextCTAEnabled, isFalse);
    },
  );

  blocTest<KnowledgeCardViewModel, KnowledgeCardState>(
    'did click common error expands section without enabling next until curiosity opened',
    build: KnowledgeCardViewModel.new,
    act: (bloc) => bloc.add(const KnowledgeCardEvent.didClickCommonError()),
    verify: (bloc) {
      expect(bloc.state.isCommonErrorExpanded, isTrue);
      expect(bloc.state.shouldDisplayCommonErrorTooltip, isFalse);
      expect(bloc.state.isNextCTAEnabled, isFalse);
    },
  );

  blocTest<KnowledgeCardViewModel, KnowledgeCardState>(
    'both sections expanded enables next CTA',
    build: KnowledgeCardViewModel.new,
    act: (bloc) => bloc
      ..add(const KnowledgeCardEvent.didClickCuriosity())
      ..add(const KnowledgeCardEvent.didClickCommonError()),
    verify: (bloc) {
      expect(bloc.state.isCuriosityExpanded, isTrue);
      expect(bloc.state.isCommonErrorExpanded, isTrue);
      expect(bloc.state.isNextCTAEnabled, isTrue);
    },
  );

  blocTest<KnowledgeCardViewModel, KnowledgeCardState>(
    'did click next increments progress when more cards remain',
    build: KnowledgeCardViewModel.new,
    seed: () => const KnowledgeCardState(
      isLoading: false,
      knowledgeCards: _twoCards,
      progress: 1,
    ),
    act: (bloc) => bloc.add(const KnowledgeCardEvent.didClickNext()),
    verify: (bloc) {
      expect(bloc.state.progress, 2);
      expect(bloc.state.knowledgeCards, _twoCards);
    },
  );

  blocTest<KnowledgeCardViewModel, KnowledgeCardState>(
    'did click next on last card does not change progress',
    build: KnowledgeCardViewModel.new,
    seed: () => const KnowledgeCardState(
      isLoading: false,
      knowledgeCards: _twoCards,
      progress: 2,
    ),
    act: (bloc) => bloc.add(const KnowledgeCardEvent.didClickNext()),
    verify: (bloc) {
      expect(bloc.state.progress, 2);
    },
  );
}
