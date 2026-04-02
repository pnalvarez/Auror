/// Profile aggregate for the signed-in user (domain layer).
class ProfileDomain {
  const ProfileDomain({
    required this.username,
    required this.email,
    required this.profileImage,
    required this.learnedCards,
    required this.revisionsDone,
    required this.followedDays,
    required this.isSubscribed,
  });

  final String username;
  final String email;

  /// Avatar image URL.
  final String profileImage;

  final int learnedCards;
  final int revisionsDone;
  final int followedDays;
  final bool isSubscribed;
}
