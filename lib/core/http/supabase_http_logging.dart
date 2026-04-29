import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// `true` in debug builds, or with `--dart-define=VERBOSE_SUPABASE_HTTP=true`.
bool shouldLogSupabaseHttp() {
  const fromDefine = bool.fromEnvironment(
    'VERBOSE_SUPABASE_HTTP',
    defaultValue: false,
  );
  return kDebugMode || fromDefine;
}

/// Wraps [http.Client] and logs Supabase Auth / REST traffic.
///
/// Masks `Authorization` values. Truncates very large bodies.
class SupabaseLoggingHttpClient extends http.BaseClient {
  SupabaseLoggingHttpClient(this._inner);

  final http.Client _inner;

  static const int _maxBodyLogChars = 24000;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (!shouldLogSupabaseHttp()) {
      return _inner.send(request);
    }

    _logOutgoing(request);

    final streamed = await _inner.send(request);
    final bytes = await streamed.stream.toBytes();

    _logIncoming(streamed, bytes, request.url);

    return http.StreamedResponse(
      Stream<List<int>>.value(bytes),
      streamed.statusCode,
      contentLength: bytes.length,
      request: streamed.request,
      headers: streamed.headers,
      reasonPhrase: streamed.reasonPhrase,
    );
  }

  void _logOutgoing(http.BaseRequest request) {
    final buffer = StringBuffer()
      ..writeln('[Supabase HTTP →] ${request.method} ${request.url}');
    request.headers.forEach((key, value) {
      buffer.writeln('  $key: ${_maskIfAuth(key, value)}');
    });
    if (request is http.Request && request.body.isNotEmpty) {
      buffer.writeln('  body: ${_truncate(request.body)}');
    } else if (request is http.StreamedRequest) {
      buffer.writeln('  body: <streamed request body not logged>');
    }
    debugPrint(buffer.toString());
  }

  void _logIncoming(
    http.StreamedResponse response,
    List<int> bytes,
    Uri requestUrl,
  ) {
    final buffer = StringBuffer()
      ..writeln(
        '[Supabase HTTP ←] ${response.statusCode} ${response.reasonPhrase ?? ''} '
        '(for $requestUrl)',
      );
    response.headers.forEach((key, value) {
      buffer.writeln('  $key: $value');
    });
    final text = utf8.decode(bytes, allowMalformed: true);
    buffer.writeln('  body: ${_truncate(text)}');
    debugPrint(buffer.toString());
  }

  static String _maskIfAuth(String headerName, String value) {
    if (headerName.toLowerCase() == 'authorization') {
      return _maskAuth(value);
    }
    return value;
  }

  static String _maskAuth(String value) {
    if (value.length <= 24) return '***';
    return '${value.substring(0, 16)}… (len ${value.length})';
  }

  static String _truncate(String text) {
    if (text.length <= _maxBodyLogChars) return text;
    return '${text.substring(0, _maxBodyLogChars)}… '
        '[truncated ${text.length - _maxBodyLogChars} chars]';
  }
}
