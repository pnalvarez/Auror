import 'package:auror/layers/data/models/guided_route_overview_data.dart';
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
}
