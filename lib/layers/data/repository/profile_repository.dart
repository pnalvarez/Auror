import 'package:auror/layers/data/datasource/api_data_source.dart';
import 'package:auror/layers/data/models/profile_data.dart';
import 'package:auror/layers/domain/models/profile_domain.dart';
import 'package:auror/layers/domain/models/user_domain.dart';
import 'package:auror/layers/domain/repository/auth_repository.dart';
import 'package:auror/layers/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  ProfileRepository(this._apiDataSource, this._authRepository);

  final IApiDataSource _apiDataSource;
  final IAuthRepository _authRepository;

  @override
  Future<ProfileDomain> getProfile() async {
    final user = _authRepository.currentUser;
    if (user == null) {
      throw StateError('Usuário não autenticado.');
    }

    final ProfileData data = await _apiDataSource.fetchProfile(
      userId: user.username,
    );

    return _mapToDomain(data, user);
  }

  ProfileDomain _mapToDomain(ProfileData data, UserDomain user) {
    return ProfileDomain(
      username: _displayName(user),
      email: user.email,
      profileImage: data.avatarUrl ?? '',
      learnedCards: data.learnedCards,
      revisionsDone: data.revisionsDone,
      followedDays: data.followedDays,
      isSubscribed: data.isSubscribed,
    );
  }

  String _displayName(UserDomain user) {
    final name = user.name.trim();
    if (name.isNotEmpty) return name;
    final email = user.email.trim();
    final at = email.indexOf('@');
    if (at > 0) return email.substring(0, at);
    return email;
  }
}
