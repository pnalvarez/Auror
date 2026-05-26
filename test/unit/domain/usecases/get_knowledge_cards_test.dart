import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/domain/models/quiz_domain.dart';
import 'package:auror/layers/domain/usecases/get_knowledge_cards.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late MockIGuidedRouteRepository repository;
  late GetKnowledgeCards sut;

  const submoduleId = '7c31fd5d-750b-48a8-844a-8e67a94bb7cd';

  const cards = [
    KnowledgeCardDomain(
      id: 'card-1',
      title: 'Mesopotâmia',
      description: 'Descrição.',
      curiosity: 'Curiosidade.',
      commonError: 'Erro comum.',
      quiz: QuizDomain(
        question: 'Pergunta?',
        option1: 'A',
        option2: 'B',
        option3: 'C',
        option4: 'D',
        correctAnswer: 1,
      ),
    ),
  ];

  setUp(() {
    repository = MockIGuidedRouteRepository();
    sut = GetKnowledgeCards(repository);
  });

  test('delegates to guided route repository fetchKnowledgeCards', () async {
    when(
      repository.fetchKnowledgeCards(submoduleId: submoduleId),
    ).thenAnswer((_) async => cards);

    final result = await sut(submoduleId: submoduleId);

    expect(result, cards);
    verify(repository.fetchKnowledgeCards(submoduleId: submoduleId)).called(1);
  });

  test('returns empty list when repository has no cards', () async {
    when(
      repository.fetchKnowledgeCards(submoduleId: submoduleId),
    ).thenAnswer((_) async => const []);

    final result = await sut(submoduleId: submoduleId);

    expect(result, isEmpty);
  });
}
