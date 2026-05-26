import 'package:auror/layers/data/models/guided_route_overview_data.dart';
import 'package:auror/layers/data/models/knowledge_card_data.dart';
import 'package:auror/layers/data/repository/guided_route_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIApiDataSource api;
  late GuidedRouteRepository sut;

  setUp(() {
    api = MockIApiDataSource();
    sut = GuidedRouteRepository(api);
  });

  test('getGuidedRoutes maps data rows to domain', () async {
    when(api.fetchGuidedRoutes(resourceName: anyNamed('resourceName')))
        .thenAnswer((_) async => [kFixtureGuidedRouteIntroData]);

    final result = await sut.getGuidedRoutes();

    expect(result, hasLength(1));
    expect(result.first.title, 'Foco profundo');
    expect(result.first.topic, 'Produtividade');
    expect(result.first.description, contains('distrações'));
    verify(api.fetchGuidedRoutes()).called(1);
  });

  test('fetchOverview maps data to domain', () async {
    const routeId = '6ce95aac-c099-45f8-b3ad-2600ddf79356';
    when(
      api.fetchGuidedRouteOverview(guidedRouteId: anyNamed('guidedRouteId')),
    ).thenAnswer(
      (_) async => GuidedRouteOverviewData.fromJson({
        'id': routeId,
        'name': 'História',
        'modules': [
          {
            'id': 'mod-1',
            'name': 'História do mundo',
            'progress': 0,
            'total_submodules': 1,
            'submodules': [
              {
                'name': 'Civilizações fundadoras',
                'has_finished': false,
                'is_available': true,
              },
            ],
          },
        ],
      }),
    );

    final result = await sut.fetchOverview(guidedRouteId: routeId);

    expect(result.title, 'História');
    expect(result.numberOfConcludedSubmodules, 0);
    expect(result.modules, hasLength(1));
    expect(result.modules.first.submodules.first.isAvailable, isTrue);
    verify(api.fetchGuidedRouteOverview(guidedRouteId: routeId)).called(1);
  });

  test('fetchKnowledgeCards maps data rows to domain', () async {
    const submoduleId = '7c31fd5d-750b-48a8-844a-8e67a94bb7cd';
    when(
      api.fetchKnowledgeCardsForSubmodule(
        submoduleId: anyNamed('submoduleId'),
      ),
    ).thenAnswer(
      (_) async => [
        KnowledgeCardData.fromJson({
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
        }),
      ],
    );

    final result = await sut.fetchKnowledgeCards(submoduleId: submoduleId);

    expect(result, hasLength(1));
    expect(result.first.id, '7a1b2c3d-4e5f-6789-a012-3456789abc01');
    expect(result.first.title, 'Mesopotâmia');
    expect(result.first.quiz.option1, 'Escrita cuneiforme');
    expect(result.first.quiz.correctAnswer, 1);
    verify(
      api.fetchKnowledgeCardsForSubmodule(submoduleId: submoduleId),
    ).called(1);
  });
}
