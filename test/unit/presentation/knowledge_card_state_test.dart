import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_state.dart';
import 'package:auror/layers/presentation/screens/knowledgecard/knowledge_card_ui.dart';
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
  group('KnowledgeCardState.initial', () {
    test('has expected defaults', () {
      const state = KnowledgeCardState.initial;

      expect(state.isLoading, isTrue);
      expect(state.knowledgeCards, isEmpty);
      expect(state.isNextCTAEnabled, isFalse);
      expect(state.isCuriosityExpanded, isFalse);
      expect(state.isCommonErrorExpanded, isFalse);
      expect(state.shouldDisplayCuriosityTooltip, isTrue);
      expect(state.shouldDisplayCommonErrorTooltip, isFalse);
      expect(state.shouldNavigateToQuiz, isFalse);
      expect(state.progress, 1);
      expect(state.errorMessage, isNull);
    });
  });

  group('KnowledgeCardState.loading', () {
    test('sets loading and clears error while preserving other fields', () {
      const base = KnowledgeCardState(
        isLoading: false,
        knowledgeCards: _twoCards,
        progress: 2,
        errorMessage: 'oops',
      );

      final state = KnowledgeCardState.loading(base);

      expect(state.isLoading, isTrue);
      expect(state.errorMessage, isNull);
      expect(state.knowledgeCards, _twoCards);
      expect(state.progress, 2);
    });
  });

  group('KnowledgeCardState.loaded', () {
    test('clears loading and error', () {
      const base = KnowledgeCardState(
        isLoading: true,
        knowledgeCards: _twoCards,
        errorMessage: 'oops',
      );

      final state = KnowledgeCardState.loaded(base);

      expect(state.isLoading, isFalse);
      expect(state.errorMessage, isNull);
      expect(state.knowledgeCards, _twoCards);
    });
  });

  group('KnowledgeCardState.failure', () {
    test('clears loading and sets error message', () {
      const base = KnowledgeCardState(
        isLoading: true,
        knowledgeCards: _twoCards,
      );

      final state = KnowledgeCardState.failure(
        base,
        message: 'network',
      );

      expect(state.isLoading, isFalse);
      expect(state.errorMessage, 'network');
      expect(state.knowledgeCards, _twoCards);
    });
  });

  group('KnowledgeCardState.curiosityExpanded', () {
    test('expands curiosity and applies tooltip and CTA flags', () {
      const base = KnowledgeCardState(
        isLoading: false,
        knowledgeCards: _twoCards,
      );

      final state = KnowledgeCardState.curiosityExpanded(
        base: base,
        showCommonErrorTooltip: true,
        isNextCtaEnabled: false,
      );

      expect(state.isCuriosityExpanded, isTrue);
      expect(state.shouldDisplayCuriosityTooltip, isFalse);
      expect(state.shouldDisplayCommonErrorTooltip, isTrue);
      expect(state.isNextCTAEnabled, isFalse);
    });
  });

  group('KnowledgeCardState.commonErrorExpanded', () {
    test('expands common error and applies CTA flag', () {
      const base = KnowledgeCardState(
        isLoading: false,
        knowledgeCards: _twoCards,
      );

      final state = KnowledgeCardState.commonErrorExpanded(
        base: base,
        isNextCtaEnabled: true,
      );

      expect(state.isCommonErrorExpanded, isTrue);
      expect(state.shouldDisplayCommonErrorTooltip, isFalse);
      expect(state.isNextCTAEnabled, isTrue);
    });
  });

  group('KnowledgeCardState.advancedToNextCard', () {
    test('increments progress when more cards remain', () {
      const base = KnowledgeCardState(
        isLoading: false,
        knowledgeCards: _twoCards,
        progress: 1,
      );

      final state = KnowledgeCardState.advancedToNextCard(base);

      expect(state, isNotNull);
      expect(state!.progress, 2);
      expect(state.knowledgeCards, _twoCards);
    });

    test('returns null on last card', () {
      const base = KnowledgeCardState(
        isLoading: false,
        knowledgeCards: _twoCards,
        progress: 2,
      );

      expect(KnowledgeCardState.advancedToNextCard(base), isNull);
    });

    test('returns null when progress exceeds card count', () {
      const base = KnowledgeCardState(
        isLoading: false,
        knowledgeCards: [_card],
        progress: 2,
      );

      expect(KnowledgeCardState.advancedToNextCard(base), isNull);
    });
  });
}
