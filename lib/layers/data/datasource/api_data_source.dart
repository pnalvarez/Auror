import 'package:auror/common/environment/auror_supabase_constants.dart';
import 'package:auror/layers/data/api/api_client.dart';
import 'package:auror/layers/data/models/profile_data.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Contrato da camada de dados para chamadas HTTP à API (PostgREST / REST v1).
abstract class IApiDataSource {
  /// GET `profiles` filtrando por [userId] (UUID do usuário autenticado).
  ///
  /// Especificação HTTP (PostgREST):
  /// - Path: `profiles` (base do client: `{SUPABASE_URL}/rest/v1/`)
  /// - Query: `select=*`, `user_id=eq.{userId}`, `limit=1`
  /// - Headers: `apikey`, `Authorization: Bearer {access_token}`
  Future<ProfileData> fetchProfile({required String userId});
}

@Injectable(as: IApiDataSource)
class ApiDataSource implements IApiDataSource {
  ApiDataSource(this._apiClient);

  final IApiClient _apiClient;

  static const String _profilesResource = 'profiles';

  @override
  Future<ProfileData> fetchProfile({required String userId}) async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      throw StateError('Sessão ausente para carregar o perfil.');
    }

    final headers = <String, String>{
      'apikey': AurorSupabaseConstants.anonKey,
      'Authorization': 'Bearer ${session.accessToken}',
    };

    final data = await _apiClient.get(
      endpoint: _profilesResource,
      queryParameters: <String, dynamic>{
        'select': '*',
        'user_id': 'eq.$userId',
        'limit': '1',
      },
      headers: headers,
    );

    return ProfileData.fromJson(_firstRowOrThrow(data));
  }

  Map<String, dynamic> _firstRowOrThrow(dynamic data) {
    if (data is List<dynamic>) {
      if (data.isEmpty) {
        throw StateError('Nenhuma linha em profiles para este usuário.');
      }
      final first = data.first;
      if (first is Map<String, dynamic>) return first;
      if (first is Map) return Map<String, dynamic>.from(first);
      throw FormatException('Resposta inesperada: $first');
    }
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw FormatException('Corpo inesperado: $data');
  }
}
