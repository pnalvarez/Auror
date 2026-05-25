import 'package:auror/layers/domain/models/guided_route_overview_domain.dart';
import 'package:auror/layers/domain/usecases/get_guided_route_overview_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks.mocks.dart';

void main() {
  late MockIGuidedRouteRepository repository;
  late GetGuidedRouteOverviewDetails sut;

  const routeId = '6ce95aac-c099-45f8-b3ad-2600ddf79356';
  const overview = GuidedRouteOverviewDomain(
    title: 'História',
    numberOfConcludedSubmodules: 0,
    modules: [],
  );

  setUp(() {
    repository = MockIGuidedRouteRepository();
    sut = GetGuidedRouteOverviewDetails(repository);
  });

  test('delegates to guided route repository fetchOverview', () async {
    when(
      repository.fetchOverview(guidedRouteId: anyNamed('guidedRouteId')),
    ).thenAnswer((_) async => overview);

    final result = await sut(guidedRouteId: routeId);

    expect(result, overview);
    verify(repository.fetchOverview(guidedRouteId: routeId)).called(1);
  });
}
