import 'dart:convert';

import 'package:auror/layers/data/api/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiClient', () {
    test('get returns decoded body on success', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com/rest/v1/'));
      dio.httpClientAdapter = _StubAdapter((options) async {
        expect(options.path, 'profiles');
        expect(options.queryParameters['limit'], '1');
        return ResponseBody.fromString(
          jsonEncode([{'user_id': 'u1'}]),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final client = ApiClient.withDio(dio);
      final data = await client.get(
        endpoint: 'profiles',
        queryParameters: {'limit': '1'},
        headers: {'Authorization': 'Bearer t'},
      );

      expect(data, isA<List<dynamic>>());
      expect((data as List).first['user_id'], 'u1');
    });

    test('post returns decoded body on success', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com/rest/v1/'));
      dio.httpClientAdapter = _StubAdapter((options) async {
        expect(options.method, 'POST');
        expect(options.path, 'rpc/set_user_subscription');
        return ResponseBody.fromString('{}', 204);
      });

      final client = ApiClient.withDio(dio);
      final data = await client.post(
        endpoint: 'rpc/set_user_subscription',
        body: {'p_subscription_id': 'sub-1'},
      );

      expect(data, '{}');
    });

    test('throws DioException when status is not 2xx', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com/rest/v1/'));
      dio.httpClientAdapter = _StubAdapter(
        (_) async => ResponseBody.fromString('error', 500),
      );

      final client = ApiClient.withDio(dio);

      expect(
        () => client.get(endpoint: 'profiles'),
        throwsA(isA<DioException>()),
      );
    });

    test('factory constructor builds client with interceptors', () {
      expect(ApiClient(), isA<ApiClient>());
    });
  });
}

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this._onFetch);

  final Future<ResponseBody> Function(RequestOptions options) _onFetch;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) =>
      _onFetch(options);
}
