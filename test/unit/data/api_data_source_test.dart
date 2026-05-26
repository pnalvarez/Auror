import 'package:auror/layers/data/datasource/api_data_source.dart';
import 'package:auror/layers/data/models/guided_route_intro_data.dart';
import 'package:auror/layers/data/models/guided_route_overview_data.dart';
import 'package:auror/layers/data/models/profile_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

Session _session({String token = 'access-token'}) {
  return Session(
    accessToken: token,
    tokenType: 'bearer',
    user: User(
      id: 'user-uuid',
      appMetadata: const {},
      userMetadata: const {},
      aud: 'authenticated',
      createdAt: DateTime.utc(2024).toIso8601String(),
    ),
  );
}

void main() {
  late MockIApiClient apiClient;
  late ApiDataSource sut;

  setUp(() {
    apiClient = MockIApiClient();
  });

  group('fetchProfile', () {
    test('throws when session is missing', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      await expectLater(
        sut.fetchProfile(userId: 'user-uuid'),
        throwsA(isA<StateError>()),
      );
      verifyNever(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          queryParameters: anyNamed('queryParameters'),
          headers: anyNamed('headers'),
        ),
      );
    });

    test('returns profile from list response', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          queryParameters: anyNamed('queryParameters'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => [kFixtureProfileData.toJson()]);

      final profile = await sut.fetchProfile(userId: 'user-uuid');

      expect(profile.userId, kFixtureProfileData.userId);
      verify(
        apiClient.get(
          endpoint: 'profiles',
          queryParameters: {
            'select': '*',
            'user_id': 'eq.user-uuid',
            'limit': '1',
          },
          headers: argThat(
            containsPair('Authorization', 'Bearer access-token'),
            named: 'headers',
          ),
        ),
      ).called(1);
    });

    test('throws when profiles list is empty', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          queryParameters: anyNamed('queryParameters'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => <dynamic>[]);

      await expectLater(
        sut.fetchProfile(userId: 'user-uuid'),
        throwsA(isA<StateError>()),
      );
    });

    test('throws FormatException on unexpected first row', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          queryParameters: anyNamed('queryParameters'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => [42]);

      await expectLater(
        sut.fetchProfile(userId: 'user-uuid'),
        throwsA(isA<FormatException>()),
      );
    });

    test('accepts single map response', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          queryParameters: anyNamed('queryParameters'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => kFixtureProfileData.toJson());

      final profile = await sut.fetchProfile(userId: 'user-uuid');
      expect(profile, isA<ProfileData>());
    });
  });

  group('fetchSubscriptions', () {
    test('parses list of maps without session auth header', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => [kFixtureSubscriptionData().toJson()]);

      final subs = await sut.fetchSubscriptions();

      expect(subs, hasLength(1));
      expect(subs.first.id, 'sub-100');
    });

    test('throws FormatException on PostgREST error map', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => {
          'code': 'PGRST116',
          'message': 'not found',
          'hint': 'h',
          'details': 'd',
        },
      );

      await expectLater(
        sut.fetchSubscriptions(),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws FormatException on unexpected root type', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => 'not-json');

      await expectLater(
        sut.fetchSubscriptions(),
        throwsA(isA<FormatException>()),
      );
    });

    test('parses row as non-typed Map', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => [
          Map<Object?, Object?>.from(kFixtureSubscriptionData().toJson()),
        ],
      );

      final subs = await sut.fetchSubscriptions();
      expect(subs.first.subscriptionName, 'Plan 100');
    });

    test('throws on unexpected row type', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => [42]);

      await expectLater(
        sut.fetchSubscriptions(),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('fetchGuidedRoutes', () {
    test('parses list with embedded category', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          queryParameters: anyNamed('queryParameters'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => [
          {
            'id': kFixtureGuidedRouteIntroData.id,
            'name': kFixtureGuidedRouteIntroData.name,
            'category_id': kFixtureGuidedRouteIntroData.categoryId,
            'description': kFixtureGuidedRouteIntroData.description,
            'is_premium': kFixtureGuidedRouteIntroData.isPremium,
            'categories': {'name': 'Produtividade'},
          },
        ],
      );

      final routes = await sut.fetchGuidedRoutes();

      expect(routes, hasLength(1));
      expect(routes.first, isA<GuidedRouteIntroData>());
      expect(routes.first.categories?.name, 'Produtividade');
      verify(
        apiClient.get(
          endpoint: 'guided_routes',
          queryParameters: const {
            'select':
                'id,name,description,category_id,categories(name),is_premium',
          },
          headers: argThat(
            containsPair('apikey', isNotEmpty),
            named: 'headers',
          ),
        ),
      ).called(1);
    });
  });

  group('fetchGuidedRouteOverview', () {
    const routeId = '6ce95aac-c099-45f8-b3ad-2600ddf79356';

    const overviewRpcBody = {
      'id': routeId,
      'name': 'História',
      'modules': [
        {
          'id': 'mod-1',
          'name': 'História do mundo',
          'submodules': [
            {
              'id': 'sub-1',
              'name': 'Civilizações fundadoras',
              'has_finished': false,
              'is_available': true,
            },
          ],
        },
      ],
    };

    test('throws when session is missing', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      await expectLater(
        sut.fetchGuidedRouteOverview(guidedRouteId: routeId),
        throwsA(isA<StateError>()),
      );
      verifyNever(
        apiClient.post(
          endpoint: anyNamed('endpoint'),
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      );
    });

    test('returns overview from get_guided_route_overview RPC', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.post(
          endpoint: anyNamed('endpoint'),
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => overviewRpcBody);

      final overview = await sut.fetchGuidedRouteOverview(
        guidedRouteId: routeId,
      );

      expect(overview, isA<GuidedRouteOverviewData>());
      expect(overview.id, routeId);
      expect(overview.title, 'História');
      expect(overview.modules, hasLength(1));
      expect(overview.modules.first.title, 'História do mundo');
      expect(overview.modules.first.submodules.first.isAvailable, isTrue);
      expect(overview.modules.first.submodules.first.isConcluded, isFalse);
      verify(
        apiClient.post(
          endpoint: 'rpc/get_guided_route_overview',
          body: {'p_guided_route_id': routeId},
          headers: argThat(
            containsPair('Authorization', 'Bearer access-token'),
            named: 'headers',
          ),
        ),
      ).called(1);
      verifyNever(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          queryParameters: anyNamed('queryParameters'),
          headers: anyNamed('headers'),
        ),
      );
    });

    test('throws StateError when RPC returns null', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.post(
          endpoint: anyNamed('endpoint'),
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => null);

      await expectLater(
        sut.fetchGuidedRouteOverview(guidedRouteId: routeId),
        throwsA(isA<StateError>()),
      );
    });

    test('throws FormatException on PostgREST error map from RPC', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.post(
          endpoint: anyNamed('endpoint'),
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => {
          'code': 'PGRST202',
          'message': 'function not found',
          'hint': null,
          'details': null,
        },
      );

      await expectLater(
        sut.fetchGuidedRouteOverview(guidedRouteId: routeId),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('fetchCurrentSubscription', () {
    test('throws when session missing', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      await expectLater(
        sut.fetchCurrentSubscription(),
        throwsA(isA<StateError>()),
      );
    });

    test('returns first current row', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          queryParameters: anyNamed('queryParameters'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => [kFixtureSubscriptionData(isCurrent: true).toJson()],
      );

      final sub = await sut.fetchCurrentSubscription();
      expect(sub.isCurrent, isTrue);
    });

    test('throws when no current subscription', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.get(
          endpoint: anyNamed('endpoint'),
          queryParameters: anyNamed('queryParameters'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => <dynamic>[]);

      await expectLater(
        sut.fetchCurrentSubscription(),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('selectSubscription', () {
    test('throws when session missing', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      await expectLater(
        sut.selectSubscription(subscriptionId: 'sub-1'),
        throwsA(isA<StateError>()),
      );
    });

    test('posts rpc payload', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.post(
          endpoint: anyNamed('endpoint'),
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async {});

      await sut.selectSubscription(
        subscriptionId: 'sub-1',
        rpcName: 'set_plan',
      );

      verify(
        apiClient.post(
          endpoint: 'rpc/set_plan',
          body: {'p_subscription_id': 'sub-1'},
          headers: argThat(
            containsPair('Prefer', 'return=minimal'),
            named: 'headers',
          ),
        ),
      ).called(1);
    });
  });

  group('cancelSubscription', () {
    test('throws when session missing', () async {
      sut = ApiDataSource.withSession(apiClient, () => null);
      await expectLater(sut.cancelSubscription(), throwsA(isA<StateError>()));
    });

    test('posts empty rpc body', () async {
      sut = ApiDataSource.withSession(apiClient, _session);
      when(
        apiClient.post(
          endpoint: anyNamed('endpoint'),
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async {});

      await sut.cancelSubscription(rpcName: 'cancel_plan');

      verify(
        apiClient.post(
          endpoint: 'rpc/cancel_plan',
          body: <String, dynamic>{},
          headers: anyNamed('headers'),
        ),
      ).called(1);
    });
  });
}
