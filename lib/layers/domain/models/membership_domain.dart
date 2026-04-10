/// Membership content for learning flows (domain layer).
class MembershipDomain {
  const MembershipDomain({required this.category, required this.isSubscribed});

  final String category;
  final bool isSubscribed;
}
