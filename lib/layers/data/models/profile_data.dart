import 'package:json_annotation/json_annotation.dart';

part 'profile_data.g.dart';

/// Linha de `public.profiles` retornada pelo PostgREST (REST v1).
@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileData {
  const ProfileData({
    required this.userId,
    this.avatarUrl,
    required this.followedDays,
    required this.learnedCards,
    required this.revisionsDone,
    this.updatedAt,
    this.isSubscribed = false,
  });

  final String userId;
  final String? avatarUrl;

  /// Sempre enviados pelo PostgREST a partir de `public.profiles`.
  final int followedDays;

  /// Sempre enviados pelo PostgREST a partir de `public.profiles`.
  final int learnedCards;

  /// Sempre enviados pelo PostgREST a partir de `public.profiles`.
  final int revisionsDone;

  final DateTime? updatedAt;

  /// Quando existir coluna no back-end; chave ausente → `false`.
  @JsonKey(defaultValue: false)
  final bool isSubscribed;

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
