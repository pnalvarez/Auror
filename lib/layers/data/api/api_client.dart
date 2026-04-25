import 'package:auror/common/environment/auror_supabase_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class IApiClient {
  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic> queryParameters = const {},
    Map<String, String> headers = const {},
  });

  Future<dynamic> post({
    required String endpoint,
    Object? body,
    Map<String, String> headers = const {},
  });
}

@LazySingleton(as: IApiClient)
class ApiClient implements IApiClient {
  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: '${AurorSupabaseConstants.supabaseUrl}/rest/v1/',
          headers: const {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

  final Dio _dio;

  @override
  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic> queryParameters = const {},
    Map<String, String> headers = const {},
  }) async {
    final response = await _dio.get<dynamic>(
      endpoint,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    _ensureSuccess(response);
    return response.data;
  }

  @override
  Future<dynamic> post({
    required String endpoint,
    Object? body,
    Map<String, String> headers = const {},
  }) async {
    final response = await _dio.post<dynamic>(
      endpoint,
      data: body,
      options: Options(headers: headers),
    );
    _ensureSuccess(response);
    return response.data;
  }

  void _ensureSuccess(Response<dynamic> response) {
    final code = response.statusCode;
    if (code == null || code < 200 || code >= 300) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'HTTP $code',
        type: DioExceptionType.badResponse,
      );
    }
  }
}
