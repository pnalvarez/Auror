import 'package:auror/common/environment/auror_supabase_constants.dart';
import 'package:auror/layers/data/api/api_client.dart';
import 'package:auror/layers/data/models/profile_data.dart';
import 'package:auror/layers/data/models/subscription_data.dart';
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

  /// GET view agregada de planos com `checkpoint_texts` (array de strings).
  ///
  /// Path: [resourceName] relativo a `{SUPABASE_URL}/rest/v1/` (ex. view no SQL).
  ///
  /// Sem query string: PostgREST devolve todas as colunas (equivalente a `select=*`).
  Future<List<SubscriptionData>> fetchSubscriptions({
    String resourceName = 'subscription_plans_with_checkpoint_texts',
  });
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

  @override
  Future<List<SubscriptionData>> fetchSubscriptions({
    String resourceName = 'full_subscriptions',
  }) async {
    final session = Supabase.instance.client.auth.currentSession;
    final headers = <String, String>{
      'apikey': AurorSupabaseConstants.anonKey,
      if (session != null) 'Authorization': 'Bearer ${session.accessToken}',
    };

    // PostgREST omits `select` → all columns (`*`). No `order` unless you need a
    // stable sort (then add `order` here or use an RPC / ordered SQL function).
    final data = await _apiClient.get(endpoint: resourceName, headers: headers);

    return _rowsAsSubscriptionData(data);
  }

  List<SubscriptionData> _rowsAsSubscriptionData(dynamic data) {
    if (data is List<dynamic>) {
      return data.map((row) {
        if (row is Map<String, dynamic>) {
          return SubscriptionData.fromJson(row);
        }
        if (row is Map) {
          return SubscriptionData.fromJson(Map<String, dynamic>.from(row));
        }
        throw FormatException('Linha inesperada: $row');
      }).toList();
    }

    // PostgREST devolve `[{...}, {...}]` para GET em view/tabela. Raiz `Map`
    // costuma ser erro (`code`/`message`) ou URL errada — não uma “lista”.
    if (data is Map) {
      final map = Map<String, dynamic>.from(data);
      if (map.containsKey('code') && map.containsKey('message')) {
        throw FormatException(
          'PostgREST: ${map['code']} — ${map['message']} '
          '(hint: ${map['hint']}, details: ${map['details']})',
        );
      }
    }

    throw FormatException(
      'Esperado lista JSON na raiz (ex.: [{...}]). Recebido: ${data.runtimeType}. '
      'Confirme GET em /rest/v1/<view> com Accept application/json; '
      'evite application/vnd.pgrst.object+json para coleções.',
    );
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
