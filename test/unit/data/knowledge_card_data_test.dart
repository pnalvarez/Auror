import 'package:auror/layers/data/models/knowledge_card_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('KnowledgeCardData.fromJson', () {
    test('maps card and nested quiz from RPC row', () {
      final data = KnowledgeCardData.fromJson({
        'id': '7a1b2c3d-4e5f-6789-a012-3456789abc01',
        'title': 'Mesopotâmia',
        'description': 'Berço da civilização.',
        'curiosity': 'Os sumérios inventaram a roda.',
        'common_error': 'Achar que era um império unificado.',
        'quiz': {
          'id': 'quiz-1',
          'question': 'Qual foi a primeira forma de escrita?',
          'option_1': 'Escrita cuneiforme',
          'option_2': 'Hieróglifos',
          'option_3': 'Alfabeto fenício',
          'option_4': 'Escrita linear A',
          'correct_answer': 1,
        },
      });

      expect(data.id, '7a1b2c3d-4e5f-6789-a012-3456789abc01');
      expect(data.title, 'Mesopotâmia');
      expect(data.quiz?.question, contains('escrita'));
      expect(data.quiz?.option1, 'Escrita cuneiforme');
      expect(data.quiz?.correctAnswer, 1);
    });

    test('allows null quiz when card has no quiz row', () {
      final data = KnowledgeCardData.fromJson({
        'id': 'card-2',
        'title': 'Egito',
        'description': 'Descrição.',
        'curiosity': 'Curiosidade.',
        'common_error': 'Erro.',
        'quiz': null,
      });

      expect(data.quiz, isNull);
    });

    test('toDomain maps card and quiz fields', () {
      final data = KnowledgeCardData.fromJson({
        'id': 'card-1',
        'title': 'Mesopotâmia',
        'description': 'Descrição.',
        'curiosity': 'Curiosidade.',
        'common_error': 'Erro comum.',
        'quiz': {
          'id': 'quiz-1',
          'question': 'Pergunta?',
          'option_1': 'A',
          'option_2': 'B',
          'option_3': 'C',
          'option_4': 'D',
          'correct_answer': 2,
        },
      });

      final domain = data.toDomain();

      expect(domain.id, 'card-1');
      expect(domain.title, 'Mesopotâmia');
      expect(domain.quiz.question, 'Pergunta?');
      expect(domain.quiz.option2, 'B');
      expect(domain.quiz.correctAnswer, 2);
    });

    test('toDomain throws when quiz is null', () {
      final data = KnowledgeCardData.fromJson({
        'id': 'card-2',
        'title': 'Egito',
        'description': 'Descrição.',
        'curiosity': 'Curiosidade.',
        'common_error': 'Erro.',
        'quiz': null,
      });

      expect(() => data.toDomain(), throwsA(isA<StateError>()));
    });
  });
}
