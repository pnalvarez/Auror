import 'package:auror/layers/data/models/quiz_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuizData.fromJson', () {
    test('maps snake_case columns from PostgREST row', () {
      final data = QuizData.fromJson({
        'id': 'b2c3d4e5-f6a7-4890-b123-456789abcdef',
        'question': 'Qual foi a primeira forma de escrita desenvolvida na Mesopotâmia?',
        'option_1': 'Escrita cuneiforme',
        'option_2': 'Hieróglifos',
        'option_3': 'Alfabeto fenício',
        'option_4': 'Escrita linear A',
        'correct_answer': 1,
      });

      expect(data.id, 'b2c3d4e5-f6a7-4890-b123-456789abcdef');
      expect(data.question, contains('Mesopotâmia'));
      expect(data.option1, 'Escrita cuneiforme');
      expect(data.option2, 'Hieróglifos');
      expect(data.option3, 'Alfabeto fenício');
      expect(data.option4, 'Escrita linear A');
      expect(data.correctAnswer, 1);
    });

    test('parses correct_answer from num', () {
      final data = QuizData.fromJson({
        'id': 'id',
        'question': 'Q',
        'option_1': 'A',
        'option_2': 'B',
        'option_3': 'C',
        'option_4': 'D',
        'correct_answer': 2.0,
      });

      expect(data.correctAnswer, 2);
    });
  });
}
