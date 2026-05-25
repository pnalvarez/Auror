import 'package:auror/common/environment/auror_supabase_constants.dart';
import 'package:auror/layers/data/api/api_client.dart';
import 'package:auror/layers/data/models/guided_route_intro_data.dart';
import 'package:auror/layers/data/models/guided_route_overview_data.dart';
import 'package:auror/layers/data/models/profile_data.dart';
import 'package:auror/layers/data/models/subscription_data.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
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
    String resourceName = 'full_subscriptions',
  });

  /// Busca apenas a assinatura atual do usuário autenticado.
  ///
  /// Espera uma view com coluna booleana `is_current`.
  Future<SubscriptionData> fetchCurrentSubscription({
    String resourceName = 'full_subscriptions',
  });

  /// Atualiza a assinatura atual do usuário autenticado.
  ///
  /// Espera um RPC no PostgREST em `/rest/v1/rpc/{rpcName}` com payload:
  /// `{ "p_subscription_id": "<id>" }`.
  Future<void> selectSubscription({
    required String subscriptionId,
    String rpcName = 'set_user_subscription',
  });

  /// Cancela a assinatura atual e retorna ao plano padrão.
  ///
  /// Espera um RPC em `/rest/v1/rpc/{rpcName}` sem payload.
  Future<void> cancelSubscription({
    String rpcName = 'cancel_user_subscription',
  });

  /// GET `guided_routes` com categoria embutida para o chip de tópico na UI.
  ///
  /// - Path: `guided_routes`
  /// - Query: `select=id,name,description,category_id,categories(name),is_premium`
  Future<List<GuidedRouteIntroData>> fetchGuidedRoutes({
    String resourceName = 'guided_routes',
  });

  /// GET visão geral: cabeçalho em [routeResourceName], módulos em [moduleResourceName]
  /// filtrados por `route_id` (evita embed `guided_routes` → `modules` vazio quando
  /// o FK não está exposto nessa relação no PostgREST).
  Future<GuidedRouteOverviewData> fetchGuidedRouteOverview({
    required String guidedRouteId,
    String routeResourceName = 'guided_routes',
    String moduleResourceName = 'modules',
  });
}

typedef CurrentSessionProvider = Session? Function();

@Injectable(as: IApiDataSource)
class ApiDataSource implements IApiDataSource {
  factory ApiDataSource(IApiClient apiClient) => ApiDataSource._(apiClient);

  @visibleForTesting
  factory ApiDataSource.withSession(
    IApiClient apiClient,
    CurrentSessionProvider currentSession,
  ) => ApiDataSource._(apiClient, currentSession: currentSession);

  ApiDataSource._(this._apiClient, {CurrentSessionProvider? currentSession})
    : _currentSession = currentSession ?? _defaultCurrentSession;

  static Session? _defaultCurrentSession() =>
      Supabase.instance.client.auth.currentSession;

  final IApiClient _apiClient;
  final CurrentSessionProvider _currentSession;

  static const String _profilesResource = 'profiles';

  static const String _guidedRouteHeaderSelect = 'id,name';

  /// `module.route_id` + `submodules` + progresso (segunda requisição).
  /// Ordenação via query params: `order`, `submodules.order` (coluna `order` asc).
  static const String _routeModulesSelect =
      'id,name,'
      'submodules('
      'id,name,'
      'user_submodule_progress(user_id,has_finished,is_available)'
      ')';

  @override
  Future<ProfileData> fetchProfile({required String userId}) async {
    final session = _currentSession();
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
    final session = _currentSession();
    final headers = <String, String>{
      'apikey': AurorSupabaseConstants.anonKey,
      if (session != null) 'Authorization': 'Bearer ${session.accessToken}',
    };

    // PostgREST omits `select` → all columns (`*`). No `order` unless you need a
    // stable sort (then add `order` here or use an RPC / ordered SQL function).
    final data = await _apiClient.get(endpoint: resourceName, headers: headers);

    return _rowsAsSubscriptionData(data);
  }

  @override
  Future<SubscriptionData> fetchCurrentSubscription({
    String resourceName = 'full_subscriptions',
  }) async {
    final session = _currentSession();
    if (session == null) {
      throw StateError('Sessão ausente para carregar assinatura atual.');
    }
    final headers = <String, String>{
      'apikey': AurorSupabaseConstants.anonKey,
      'Authorization': 'Bearer ${session.accessToken}',
    };

    final data = await _apiClient.get(
      endpoint: resourceName,
      queryParameters: const <String, dynamic>{
        'is_current': 'eq.true',
        'limit': '1',
      },
      headers: headers,
    );
    final rows = _rowsAsSubscriptionData(data);
    if (rows.isEmpty) {
      throw StateError('Nenhuma assinatura atual encontrada para o usuário.');
    }
    return rows.first;
  }

  @override
  Future<void> selectSubscription({
    required String subscriptionId,
    String rpcName = 'set_user_subscription',
  }) async {
    final session = _currentSession();
    if (session == null) {
      throw StateError('Sessão ausente para selecionar assinatura.');
    }
    final headers = <String, String>{
      'apikey': AurorSupabaseConstants.anonKey,
      'Authorization': 'Bearer ${session.accessToken}',
      // RPC de update: não precisamos de payload de retorno.
      'Prefer': 'return=minimal',
    };

    await _apiClient.post(
      endpoint: 'rpc/$rpcName',
      body: <String, dynamic>{'p_subscription_id': subscriptionId},
      headers: headers,
    );
  }

  @override
  Future<List<GuidedRouteIntroData>> fetchGuidedRoutes({
    String resourceName = 'guided_routes',
  }) async {
    final session = _currentSession();
    final headers = <String, String>{
      'apikey': AurorSupabaseConstants.anonKey,
      if (session != null) 'Authorization': 'Bearer ${session.accessToken}',
    };

    final data = await _apiClient.get(
      endpoint: resourceName,
      queryParameters: const <String, dynamic>{
        'select': 'id,name,description,category_id,categories(name),is_premium',
      },
      headers: headers,
    );

    return _rowsAsGuidedRouteIntroData(data);
  }

  @override
  Future<GuidedRouteOverviewData> fetchGuidedRouteOverview({
    required String guidedRouteId,
    String routeResourceName = 'guided_routes',
    String moduleResourceName = 'modules',
  }) async {
    final session = _currentSession();
    if (session == null) {
      throw StateError('Sessão ausente para carregar a rota guiada.');
    }

    final userId = session.user.id;
    final headers = <String, String>{
      'apikey': AurorSupabaseConstants.anonKey,
      'Authorization': 'Bearer ${session.accessToken}',
    };

    final routeData = await _apiClient.get(
      endpoint: routeResourceName,
      queryParameters: <String, dynamic>{
        'select': _guidedRouteHeaderSelect,
        'id': 'eq.$guidedRouteId',
        'limit': '1',
      },
      headers: headers,
    );

    final routeRow = _firstRowOrThrow(
      routeData,
      emptyMessage: 'Nenhuma rota guiada encontrada.',
    );
    _throwIfPostgrestErrorMap(routeRow);

    final modulesData = await _apiClient.get(
      endpoint: moduleResourceName,
      queryParameters: <String, dynamic>{
        'select': _routeModulesSelect,
        'route_id': 'eq.$guidedRouteId',
        'order': 'order',
        'submodules.order': 'order',
      },
      headers: headers,
    );

    final modules = _rowsAsMaps(modulesData);
    final overviewRow = <String, dynamic>{
      'id': routeRow['id'],
      'name': routeRow['name'],
      'modules': modules,
    };
    _narrowSubmoduleProgressForUser(overviewRow, userId);
    return GuidedRouteOverviewData.fromJson(overviewRow);
  }

  @override
  Future<void> cancelSubscription({
    String rpcName = 'cancel_user_subscription',
  }) async {
    final session = _currentSession();
    if (session == null) {
      throw StateError('Sessão ausente para cancelar assinatura.');
    }
    final headers = <String, String>{
      'apikey': AurorSupabaseConstants.anonKey,
      'Authorization': 'Bearer ${session.accessToken}',
      'Prefer': 'return=minimal',
    };

    await _apiClient.post(
      endpoint: 'rpc/$rpcName',
      body: const <String, dynamic>{},
      headers: headers,
    );
  }

  List<Map<String, dynamic>> _rowsAsMaps(dynamic data) {
    if (data is List<dynamic>) {
      return data.map((row) {
        if (row is Map<String, dynamic>) return row;
        if (row is Map) return Map<String, dynamic>.from(row);
        throw FormatException('Linha inesperada: $row');
      }).toList();
    }

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
      'Esperado lista JSON na raiz. Recebido: ${data.runtimeType}.',
    );
  }

  List<GuidedRouteIntroData> _rowsAsGuidedRouteIntroData(dynamic data) {
    if (data is List<dynamic>) {
      return data.map((row) {
        if (row is Map<String, dynamic>) {
          return GuidedRouteIntroData.fromJson(row);
        }
        if (row is Map) {
          return GuidedRouteIntroData.fromJson(Map<String, dynamic>.from(row));
        }
        throw FormatException('Linha inesperada: $row');
      }).toList();
    }

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
      'Esperado lista JSON na raiz para guided_routes. Recebido: ${data.runtimeType}.',
    );
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

  Map<String, dynamic> _firstRowOrThrow(
    dynamic data, {
    String emptyMessage = 'Nenhuma linha encontrada.',
  }) {
    if (data is List<dynamic>) {
      if (data.isEmpty) {
        throw StateError(emptyMessage);
      }
      final first = data.first;
      if (first is Map<String, dynamic>) return first;
      if (first is Map) return Map<String, dynamic>.from(first);
      throw FormatException('Resposta inesperada: $first');
    }
    if (data is Map<String, dynamic>) {
      _throwIfPostgrestErrorMap(data);
      return data;
    }
    if (data is Map) {
      final map = Map<String, dynamic>.from(data);
      _throwIfPostgrestErrorMap(map);
      return map;
    }
    throw FormatException('Corpo inesperado: $data');
  }

  void _throwIfPostgrestErrorMap(Map<String, dynamic> map) {
    if (map.containsKey('code') && map.containsKey('message')) {
      throw FormatException(
        'PostgREST: ${map['code']} — ${map['message']} '
        '(hint: ${map['hint']}, details: ${map['details']})',
      );
    }
  }

  /// PostgREST embedded filters on `user_submodule_progress` act like INNER JOIN
  /// and drop modules when the user has no progress rows yet.
  static void _narrowSubmoduleProgressForUser(
    Map<String, dynamic> routeRow,
    String userId,
  ) {
    final modulesKey = routeRow.containsKey('modules') ? 'modules' : 'module';
    final modulesRaw = routeRow[modulesKey];
    if (modulesRaw is! List) return;

    final modules = <dynamic>[];
    for (final moduleEntry in modulesRaw) {
      if (moduleEntry is! Map) continue;
      final moduleMap = Map<String, dynamic>.from(moduleEntry);
      final submodulesRaw = moduleMap['submodules'];
      if (submodulesRaw is! List) {
        modules.add(moduleMap);
        continue;
      }

      final submodules = <dynamic>[];
      for (final submoduleEntry in submodulesRaw) {
        if (submoduleEntry is! Map) continue;
        final submoduleMap = Map<String, dynamic>.from(submoduleEntry);
        final progress = submoduleMap['user_submodule_progress'];
        if (progress is List) {
          submoduleMap['user_submodule_progress'] = progress
              .whereType<Map>()
              .map(Map<String, dynamic>.from)
              .where((row) => row['user_id'] == userId)
              .toList();
        }
        submodules.add(submoduleMap);
      }
      moduleMap['submodules'] = submodules;
      modules.add(moduleMap);
    }
    routeRow[modulesKey] = modules;
  }
}
