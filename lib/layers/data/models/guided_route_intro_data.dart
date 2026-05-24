import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guided_route_intro_data.g.dart';

/// Categoria embutida via PostgREST (`select=...,categories(name)`).
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class GuidedRouteCategoryData {
  const GuidedRouteCategoryData({required this.name});

  final String name;

  factory GuidedRouteCategoryData.fromJson(Map<String, dynamic> json) =>
      _$GuidedRouteCategoryDataFromJson(json);
}

/// Linha de `public.guided_routes` (REST v1 / PostgREST).
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class GuidedRouteIntroData {
  const GuidedRouteIntroData({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.isPremium,
    this.categories,
  });

  final String id;
  final String name;
  final String categoryId;
  final String description;
  @JsonKey(name: 'is_premium')
  final bool isPremium;

  /// Relação `categories` quando o GET usa `select=...,categories(name)`.
  final GuidedRouteCategoryData? categories;

  factory GuidedRouteIntroData.fromJson(Map<String, dynamic> json) =>
      _$GuidedRouteIntroDataFromJson(json);

  GuidedRouteIntroDomain toDomain() =>
      GuidedRouteIntroDomain(
        topic: categories?.name ?? '',
        isPremiumMode: isPremium,
        title: name,
        description: description,
      );
}
