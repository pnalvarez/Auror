import 'package:auror/layers/data/models/profile_data.dart';
import 'package:auror/layers/data/models/subscription_data.dart';
import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/domain/models/profile_domain.dart';
import 'package:auror/layers/domain/models/revision_domain.dart';
import 'package:auror/layers/domain/models/subscription_domain.dart';
import 'package:auror/layers/domain/models/user_domain.dart';

const UserDomain kFixtureUser = UserDomain(
  username: 'user-uuid',
  name: 'Test User',
  email: 'test@example.com',
  profileImage: '',
);

const UserDomain kFixtureUserEmailOnly = UserDomain(
  username: 'id-2',
  name: '',
  email: 'learner@example.com',
  profileImage: '',
);

const ProfileData kFixtureProfileData = ProfileData(
  userId: 'user-uuid',
  avatarUrl: 'https://example.com/avatar.png',
  followedDays: 7,
  learnedCards: 12,
  revisionsDone: 3,
  isSubscribed: true,
);

ProfileDomain kExpectedProfileDomain(UserDomain user) {
  return ProfileDomain(
    username: user.name.trim().isNotEmpty
        ? user.name.trim()
        : user.email.trim().split('@').first,
    email: user.email,
    profileImage: kFixtureProfileData.avatarUrl ?? '',
    learnedCards: kFixtureProfileData.learnedCards,
    revisionsDone: kFixtureProfileData.revisionsDone,
    followedDays: kFixtureProfileData.followedDays,
    isSubscribed: kFixtureProfileData.isSubscribed,
  );
}

SubscriptionData kFixtureSubscriptionData({bool isCurrent = false, int price = 100}) {
  return SubscriptionData(
    id: 'sub-$price',
    subscriptionName: 'Plan $price',
    description: 'Description',
    isPaid: true,
    isCurrent: isCurrent,
    price: price,
    period: 30,
    checkpointTexts: const ['Benefit a'],
  );
}

const KnowledgeCardDomain kFixtureKnowledgeCard = KnowledgeCardDomain(
  id: 'card-1',
  category: 'Cat',
  title: 'Card title',
  quote: 'Quote',
  description: 'Desc',
  videoUrl: 'https://example.com/video.mp4',
  practicalExample: 'Example',
  commonError: 'Error',
);

RevisionDomain kFixtureRevision({String id = 'rev-1', String cardId = 'c1'}) {
  return RevisionDomain(
    id: id,
    title: 'Revision title',
    question: 'Question?',
    videoUrl: 'https://example.com/v.mp4',
    category: 'Cat',
    minutes: 5,
    correctAnswer: 'Answer text',
    cardId: cardId,
  );
}

SubscriptionDomain kFixtureSubscriptionDomain({
  String id = '1',
  bool isCurrent = true,
  int price = 50,
  String? nextId,
}) {
  return SubscriptionDomain(
    id: id,
    subscriptionName: 'Basic',
    description: 'Desc',
    isPaid: true,
    benefits: const ['b1'],
    isCurrent: isCurrent,
    price: price,
    period: 30,
    nextSubscriptionId: nextId,
  );
}
