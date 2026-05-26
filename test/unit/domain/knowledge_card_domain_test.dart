import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/domain/models/quiz_domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const quiz = QuizDomain(
    question: 'Pergunta?',
    option1: 'A',
    option2: 'B',
    option3: 'C',
    option4: 'D',
    correctAnswer: 1,
  );

  const card = KnowledgeCardDomain(
    id: 'card-1',
    title: 'Mesopotâmia',
    description: 'Descrição.',
    curiosity: 'Curiosidade.',
    commonError: 'Erro comum.',
    quiz: quiz,
  );

  test('exposes card and quiz fields', () {
    expect(card.id, 'card-1');
    expect(card.title, 'Mesopotâmia');
    expect(card.quiz.question, 'Pergunta?');
    expect(card.quiz.option1, 'A');
    expect(card.quiz.correctAnswer, 1);
  });
}
