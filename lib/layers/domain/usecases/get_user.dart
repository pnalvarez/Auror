import 'package:auror/layers/domain/models/user_domain.dart';
import 'package:injectable/injectable.dart';

abstract class IGetUser {
  Future<UserDomain> call();
}

@Injectable(as: IGetUser)
class GetUser implements IGetUser {
  @override
  Future<UserDomain> call() async {
    return const UserDomain(
      username: 'auror_learner',
      name: 'Auror Learner',
      email: '',
      profileImage: 'https://picsum.photos/seed/auror-profile/256/256',
    );
  }
}
