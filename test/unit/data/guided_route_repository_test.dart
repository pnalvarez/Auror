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
}
