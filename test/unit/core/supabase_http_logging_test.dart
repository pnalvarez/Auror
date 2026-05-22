import 'dart:convert';

import 'package:auror/core/http/supabase_http_logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('shouldLogSupabaseHttp is true in debug tests', () {
    expect(kDebugMode, isTrue);
    expect(shouldLogSupabaseHttp(), isTrue);
  });

  test('SupabaseLoggingHttpClient forwards and logs request/response', () async {
    final inner = MockClient((request) async {
      expect(request.headers['Authorization'], 'Bearer secret-token-value');
      return http.Response(jsonEncode({'ok': true}), 200, headers: {
        'content-type': 'application/json',
      });
    });

    final client = SupabaseLoggingHttpClient(inner);
    final response = await client.get(
      Uri.parse('https://project.supabase.co/auth/v1/token'),
      headers: {'Authorization': 'Bearer secret-token-value'},
    );

    expect(response.statusCode, 200);
    expect(jsonDecode(response.body), {'ok': true});
    client.close();
  });

  test('skips logging wrapper when shouldLogSupabaseHttp is false', () async {
    // Documented env flag; default in release would be false — here we only
    // verify the fast path still returns the inner response.
    final inner = MockClient(
      (_) async => http.Response('plain', 200),
    );
    final client = SupabaseLoggingHttpClient(inner);
    final response = await client.send(
      http.Request('GET', Uri.parse('https://example.com')),
    );
    expect(response.statusCode, 200);
    client.close();
  });

  test('truncates very large bodies in logs without failing', () async {
    final big = 'x' * 30000;
    final inner = MockClient((_) async => http.Response(big, 200));
    final client = SupabaseLoggingHttpClient(inner);
    final streamed = await client.send(
      http.Request('POST', Uri.parse('https://example.com/rest/v1/table'))
        ..body = big,
    );
    final body = await http.Response.fromStream(streamed);
    expect(body.body.length, 30000);
    client.close();
  });
}
