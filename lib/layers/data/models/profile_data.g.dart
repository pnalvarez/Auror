// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
  userId: json['user_id'] as String,
  avatarUrl: json['avatar_url'] as String?,
  followedDays: (json['followed_days'] as num?)?.toInt() ?? 0,
  learnedCards: (json['learned_cards'] as num?)?.toInt() ?? 0,
  revisionsDone: (json['revisions_done'] as num?)?.toInt() ?? 0,
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  isSubscribed: json['is_subscribed'] as bool? ?? false,
);

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'avatar_url': instance.avatarUrl,
      'followed_days': instance.followedDays,
      'learned_cards': instance.learnedCards,
      'revisions_done': instance.revisionsDone,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'is_subscribed': instance.isSubscribed,
    };
