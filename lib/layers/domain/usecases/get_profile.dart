import 'package:auror/layers/domain/usecases/models/profile_domain.dart';
import 'package:injectable/injectable.dart';

abstract class IGetProfile {
  Future<ProfileDomain> call();
}

@Injectable(as: IGetProfile)
class GetProfile implements IGetProfile {
  @override
  Future<ProfileDomain> call() async {
    return const ProfileDomain(
      username: 'auror_learner',
      email: 'learner@example.com',
      profileImage: 'https://picsum.photos/seed/auror-profile/256/256',
      learnedCards: 42,
      revisionsDone: 128,
      followedDays: 7,
      isSubscribed: false,
    );
  }
}
