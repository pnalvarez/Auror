import 'package:json_annotation/json_annotation.dart';

part 'profile_data.g.dart';

/// Linha de `public.profiles` retornada pelo PostgREST (REST v1).
@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileData {
  const ProfileData({
    required this.userId,
    this.avatarUrl,
    this.followedDays = 0,
    this.learnedCards = 0,
    this.revisionsDone = 0,
    this.updatedAt,
    this.isSubscribed = false,
  });

  final String userId;
  final String? avatarUrl;

  @JsonKey(defaultValue: 0)
  final int followedDays;

  @JsonKey(defaultValue: 0)
  final int learnedCards;

  @JsonKey(defaultValue: 0)
  final int revisionsDone;

  final DateTime? updatedAt;

  /// Quando existir coluna no back-end; chave ausente → `false`.
  @JsonKey(defaultValue: false)
  final bool isSubscribed;

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
