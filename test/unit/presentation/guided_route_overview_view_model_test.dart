import 'package:auror/layers/domain/usecases/guided_route_overview_mock_data.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_event.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_state.dart';
import 'package:auror/layers/presentation/screens/guidedrouteoverview/guided_route_overview_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIGetGuidedRouteOverviewDetails getOverviewDetails;

  const guidedRouteId = '6ce95aac-c099-45f8-b3ad-2600ddf79356';

  setUp(() {
    getOverviewDetails = MockIGetGuidedRouteOverviewDetails();
  });

  blocTest<GuidedRouteOverviewViewModel, GuidedRouteOverviewState>(
    'load requested maps overview from use case',
    build: () {
      when(
        getOverviewDetails(guidedRouteId: anyNamed('guidedRouteId')),
      ).thenAnswer(
        (_) async => kMockGuidedRouteOverviewDomain,
      );
      return GuidedRouteOverviewViewModel(guidedRouteId, getOverviewDetails);
    },
    act: (bloc) => bloc.add(const GuidedRouteOverviewLoadRequested()),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.overview, isNotNull);
      expect(bloc.state.overview!.title, kMockGuidedRouteOverviewDomain.title);
      expect(bloc.state.overview!.moduleListItemInputs, hasLength(1));
      verify(getOverviewDetails(guidedRouteId: guidedRouteId)).called(1);
    },
  );

  blocTest<GuidedRouteOverviewViewModel, GuidedRouteOverviewState>(
    'load failure clears overview and sets error',
    build: () {
      when(
        getOverviewDetails(guidedRouteId: anyNamed('guidedRouteId')),
      ).thenThrow(Exception('fail'));
      return GuidedRouteOverviewViewModel(guidedRouteId, getOverviewDetails);
    },
    act: (bloc) => bloc.add(const GuidedRouteOverviewLoadRequested()),
    verify: (bloc) {
      expect(bloc.state.overview, isNull);
      expect(bloc.state.errorMessage, contains('fail'));
    },
  );

  blocTest<GuidedRouteOverviewViewModel, GuidedRouteOverviewState>(
    'retry load requested fetches overview again',
    build: () {
      when(
        getOverviewDetails(guidedRouteId: anyNamed('guidedRouteId')),
      ).thenThrow(Exception('fail'));
      return GuidedRouteOverviewViewModel(guidedRouteId, getOverviewDetails);
    },
    act: (bloc) async {
      bloc.add(const GuidedRouteOverviewLoadRequested());
      await Future<void>.delayed(Duration.zero);
      when(
        getOverviewDetails(guidedRouteId: anyNamed('guidedRouteId')),
      ).thenAnswer((_) async => kMockGuidedRouteOverviewDomain);
      bloc.add(const GuidedRouteOverviewLoadRequested());
    },
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.overview, isNotNull);
      verify(getOverviewDetails(guidedRouteId: guidedRouteId)).called(2);
    },
  );
}
