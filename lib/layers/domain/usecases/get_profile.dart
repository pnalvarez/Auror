import 'package:auror/layers/domain/models/profile_domain.dart';
import 'package:auror/layers/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IGetProfile {
  Future<ProfileDomain> call();
}

@Injectable(as: IGetProfile)
class GetProfile implements IGetProfile {
  GetProfile(this._profileRepository);

  final IProfileRepository _profileRepository;

  @override
  Future<ProfileDomain> call() => _profileRepository.getProfile();
}
