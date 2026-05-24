import 'package:auror/layers/data/datasource/api_data_source.dart';
import 'package:auror/layers/data/models/guided_route_intro_data.dart';
import 'package:auror/layers/data/models/profile_data.dart';
import 'package:auror/layers/data/models/subscription_data.dart';
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
      ).thenAnswer(
        (_) async => [
          kFixtureProfileData.toJson(),
        ],
      );

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
      ).thenAnswer(
        (_) async => [
          kFixtureSubscriptionData().toJson(),
        ],
      );

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
        (_) async => [
          kFixtureSubscriptionData(isCurrent: true).toJson(),
        ],
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

      await sut.selectSubscription(subscriptionId: 'sub-1', rpcName: 'set_plan');

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
      await expectLater(
        sut.cancelSubscription(),
        throwsA(isA<StateError>()),
      );
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
