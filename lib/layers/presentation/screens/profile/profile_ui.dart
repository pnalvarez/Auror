import 'package:auror/layers/domain/models/profile_domain.dart';
import 'package:auror/layers/domain/models/subscription_domain.dart';
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
    required String subscriptionPlan,
    required bool hasUpgrade,
  }) = _ProfileUI;

  factory ProfileUI.fromDomain(
    ProfileDomain profileDomain,
    SubscriptionDomain subscriptionDomain,
  ) {
    return ProfileUI(
      username: profileDomain.username,
      email: profileDomain.email,
      profileImageUrl: profileDomain.profileImage,
      learnedCards: profileDomain.learnedCards,
      revisionsDone: profileDomain.revisionsDone,
      followedDays: profileDomain.followedDays,
      subscriptionPlan: 'Plano ${subscriptionDomain.subscriptionName}',
      hasUpgrade: subscriptionDomain.hasUpgrade,
    );
  }
}
