import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';
import 'package:auror/layers/domain/models/membership_domain.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_state.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_event.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIGetGuidedRouteIntros getIntros;
  late MockIGetMembership getMembership;

  setUp(() {
    getIntros = MockIGetGuidedRouteIntros();
    getMembership = MockIGetMembership();
  });

  blocTest<GuidedRoutesHubViewModel, GuidedRoutesHubState>(
    'load requested combines intros and membership',
    build: () {
      when(getIntros()).thenAnswer(
        (_) async => const [
          GuidedRouteIntroDomain(
            topic: 'T',
            isPremiumMode: false,
            title: 'Title',
            description: 'D',
          ),
        ],
      );
      when(getMembership()).thenAnswer(
        (_) async => const MembershipDomain(
          category: 'Pro',
          isSubscribed: true,
        ),
      );
      return GuidedRoutesHubViewModel(getIntros, getMembership);
    },
    act: (bloc) => bloc.add(const GuidedRoutesHubLoadRequested()),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.routes, hasLength(1));
      expect(bloc.state.isPremium, isTrue);
      verify(getIntros()).called(1);
      verify(getMembership()).called(1);
    },
  );
}
