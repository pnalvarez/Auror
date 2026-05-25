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

  setUp(() {
    getOverviewDetails = MockIGetGuidedRouteOverviewDetails();
  });

  blocTest<GuidedRouteOverviewViewModel, GuidedRouteOverviewState>(
    'load requested maps overview from use case',
    build: () {
      when(getOverviewDetails()).thenAnswer(
        (_) async => kMockGuidedRouteOverviewDomain,
      );
      return GuidedRouteOverviewViewModel(getOverviewDetails);
    },
    act: (bloc) => bloc.add(const GuidedRouteOverviewLoadRequested()),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.overview, isNotNull);
      expect(bloc.state.overview!.title, kMockGuidedRouteOverviewDomain.title);
      expect(bloc.state.overview!.moduleListItemInputs, hasLength(1));
      verify(getOverviewDetails()).called(1);
    },
  );

  blocTest<GuidedRouteOverviewViewModel, GuidedRouteOverviewState>(
    'load failure clears overview and sets error',
    build: () {
      when(getOverviewDetails()).thenThrow(Exception('fail'));
      return GuidedRouteOverviewViewModel(getOverviewDetails);
    },
    act: (bloc) => bloc.add(const GuidedRouteOverviewLoadRequested()),
    verify: (bloc) {
      expect(bloc.state.overview, isNull);
      expect(bloc.state.errorMessage, contains('fail'));
    },
  );
}
