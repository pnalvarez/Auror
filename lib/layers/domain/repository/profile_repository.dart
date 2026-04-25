import 'package:auror/layers/domain/models/profile_domain.dart';

abstract class IProfileRepository {
  Future<ProfileDomain> getProfile();
}
