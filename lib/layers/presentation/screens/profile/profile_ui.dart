import 'package:auror/layers/domain/usecases/models/profile_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_ui.freezed.dart';

/// Presentation model for the profile tab, mapped from [ProfileDomain].
@freezed
sealed class ProfileUI with _$ProfileUI {
  const ProfileUI._();

  const factory ProfileUI({
    required String username,
    required String email,
    required String profileImageUrl,
    required int learnedCards,
    required int revisionsDone,
    required int followedDays,
    required bool isSubscribed,
  }) = _ProfileUI;

  factory ProfileUI.fromDomain(ProfileDomain domain) {
    return ProfileUI(
      username: domain.username,
      email: domain.email,
      profileImageUrl: domain.profileImage,
      learnedCards: domain.learnedCards,
      revisionsDone: domain.revisionsDone,
      followedDays: domain.followedDays,
      isSubscribed: domain.isSubscribed,
    );
  }
}
