import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';
import 'package:auror/layers/domain/models/subscription_domain.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_event.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_state.dart';
import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIGetGuidedRouteIntros getIntros;
  late MockIGetCurrentSubscription getCurrentSubscription;

  setUp(() {
    getIntros = MockIGetGuidedRouteIntros();
    getCurrentSubscription = MockIGetCurrentSubscription();
  });

  blocTest<GuidedRoutesHubViewModel, GuidedRoutesHubState>(
    'load requested combines intros and subscription',
    build: () {
      when(getIntros()).thenAnswer(
        (_) async => const [
          GuidedRouteIntroDomain(
            id: 'route-1',
            topic: 'T',
            isPremiumMode: false,
            title: 'Title',
            description: 'D',
          ),
        ],
      );
      when(getCurrentSubscription()).thenAnswer(
        (_) async => SubscriptionDomain(
          id: 'ultra',
          subscriptionName: 'Ultra',
          description: 'Paid plan',
          isPaid: true,
          benefits: const [],
          isCurrent: true,
          price: 3990,
          period: 30,
        ),
      );
      return GuidedRoutesHubViewModel(getIntros, getCurrentSubscription);
    },
    act: (bloc) => bloc.add(const GuidedRoutesHubLoadRequested()),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.routes, hasLength(1));
      expect(bloc.state.isUserPremium, isTrue);
      verify(getIntros()).called(1);
      verify(getCurrentSubscription()).called(1);
    },
  );

  blocTest<GuidedRoutesHubViewModel, GuidedRoutesHubState>(
    'load failure clears routes and sets error',
    build: () {
      when(getIntros()).thenThrow(Exception('fail'));
      return GuidedRoutesHubViewModel(getIntros, getCurrentSubscription);
    },
    act: (bloc) => bloc.add(const GuidedRoutesHubLoadRequested()),
    verify: (bloc) {
      expect(bloc.state.routes, isEmpty);
      expect(bloc.state.errorMessage, contains('fail'));
    },
  );
}
