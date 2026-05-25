import 'package:auror/layers/domain/models/guided_route_overview_domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guided_route_overview_data.g.dart';

/// Progresso do usuário em um submódulo (`public.user_submodule_progress` +
/// `public.submodules.name`).
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class GuidedRouteSubmoduleData {
  const GuidedRouteSubmoduleData({
    required this.title,
    required this.isConcluded,
    required this.isAvailable,
  });

  /// Título exibido; origem SQL: `submodules.name`.
  @JsonKey(readValue: _readSubmoduleTitle)
  final String title;

  /// Origem SQL: `user_submodule_progress.has_finished`.
  @JsonKey(name: 'has_finished', readValue: _readHasFinished)
  final bool isConcluded;

  /// Origem SQL: `user_submodule_progress.is_available`.
  @JsonKey(readValue: _readIsAvailable)
  final bool isAvailable;

  factory GuidedRouteSubmoduleData.fromJson(Map<String, dynamic> json) =>
      _$GuidedRouteSubmoduleDataFromJson(json);

  GuidedRouteSubmoduleEntryDomain toDomain() => GuidedRouteSubmoduleEntryDomain(
    title: title,
    isConcluded: isConcluded,
    isAvailable: isAvailable,
  );

  static Object? _readSubmoduleTitle(Map json, String key) =>
      json['name'] as String? ?? json['title'] as String? ?? '';

  static Object? _readHasFinished(Map json, String key) {
    final direct = json['has_finished'];
    if (direct is bool) return direct;
    return _firstProgressRow(json)?['has_finished'] as bool? ?? false;
  }

  static Object? _readIsAvailable(Map json, String key) {
    final direct = json['is_available'];
    if (direct is bool) return direct;
    return _firstProgressRow(json)?['is_available'] as bool? ?? false;
  }

  static Map<String, dynamic>? _firstProgressRow(Map json) {
    final embedded = json['user_submodule_progress'];
    if (embedded is List && embedded.isNotEmpty) {
      final row = embedded.first;
      if (row is Map<String, dynamic>) return row;
      if (row is Map) return Map<String, dynamic>.from(row);
    }
    return null;
  }
}

/// Módulo da rota (`public.module`) com submódulos e progresso agregado.
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class GuidedRouteModuleData {
  const GuidedRouteModuleData({
    required this.id,
    required this.title,
    required this.progress,
    required this.totalSubmodules,
    required this.submodules,
  });

  /// `module.id`.
  final String id;

  /// Título exibido; origem SQL: `module.name`.
  @JsonKey(readValue: _readModuleTitle)
  final String title;

  /// Quantidade concluída (campo calculado ou agregado na query).
  @JsonKey(readValue: _readProgress)
  final int progress;

  /// Total de submódulos do módulo (campo calculado ou `submodules.length`).
  @JsonKey(readValue: _readTotalSubmodules)
  final int totalSubmodules;

  @JsonKey(readValue: _readSubmodules)
  final List<GuidedRouteSubmoduleData> submodules;

  factory GuidedRouteModuleData.fromJson(Map<String, dynamic> json) =>
      _$GuidedRouteModuleDataFromJson(json);

  GuidedRouteModuleDomain toDomain() => GuidedRouteModuleDomain(
    title: title,
    progress: progress,
    totalSubmodules: totalSubmodules,
    submodules: submodules.map((s) => s.toDomain()).toList(),
  );

  static Object? _readModuleTitle(Map json, String key) =>
      json['name'] as String? ?? json['title'] as String? ?? '';

  static Object? _readProgress(Map json, String key) {
    final value = json['progress'];
    if (value is int) return value;
    if (value is num) return value.toInt();
    final subs = _submoduleMaps(json);
    var finished = 0;
    for (final sub in subs) {
      if (GuidedRouteSubmoduleData._readHasFinished(sub, 'has_finished') == true) {
        finished++;
      }
    }
    return finished;
  }

  static Object? _readTotalSubmodules(Map json, String key) {
    final value = json['total_submodules'];
    if (value is int) return value;
    if (value is num) return value.toInt();
    return _submoduleMaps(json).length;
  }

  static Object? _readSubmodules(Map json, String key) {
    final raw = json['submodules'] ?? json['submodule'];
    if (raw is! List) return const <Map<String, dynamic>>[];
    return raw
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  static List<Map<String, dynamic>> _submoduleMaps(Map json) {
    final raw = _readSubmodules(json, 'submodules');
    if (raw is List<Map<String, dynamic>>) return raw;
    if (raw is List) {
      return raw.whereType<Map>().map(Map<String, dynamic>.from).toList();
    }
    return const [];
  }
}

/// Visão geral da rota guiada (`public.guided_routes` / `route` + módulos).
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class GuidedRouteOverviewData {
  const GuidedRouteOverviewData({
    required this.id,
    required this.title,
    required this.numberOfSubmodules,
    required this.modules,
  });

  /// `guided_routes.id` ou `route.id`.
  final String id;

  /// Título exibido; origem SQL: `guided_routes.name` / `route.name`.
  @JsonKey(readValue: _readRouteTitle)
  final String title;

  @JsonKey(readValue: _readNumberOfSubmodules)
  final int numberOfSubmodules;

  @JsonKey(readValue: _readModules)
  final List<GuidedRouteModuleData> modules;

  factory GuidedRouteOverviewData.fromJson(Map<String, dynamic> json) =>
      _$GuidedRouteOverviewDataFromJson(json);

  GuidedRouteOverviewDomain toDomain() => GuidedRouteOverviewDomain(
    title: title,
    numberOfSubmodules: numberOfSubmodules,
    modules: modules.map((m) => m.toDomain()).toList(),
  );

  static Object? _readRouteTitle(Map json, String key) =>
      json['name'] as String? ?? json['title'] as String? ?? '';

  static Object? _readNumberOfSubmodules(Map json, String key) {
    final value = json['number_of_submodules'];
    if (value is int) return value;
    if (value is num) return value.toInt();
    final mods = _readModules(json, 'modules');
    if (mods is List<GuidedRouteModuleData>) {
      return mods.where((m) => m.progress >= m.totalSubmodules && m.totalSubmodules > 0).length;
    }
    if (mods is List) return mods.length;
    return 0;
  }

  static Object? _readModules(Map json, String key) {
    final raw = json['modules'] ?? json['module'];
    if (raw is! List) return const <Map<String, dynamic>>[];
    return raw
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
