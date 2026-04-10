import 'package:auror/layers/domain/models/membership_domain.dart';
import 'package:injectable/injectable.dart';

abstract class IGetMembership {
  Future<MembershipDomain> call();
}

@Injectable(as: IGetMembership)
class GetMembership implements IGetMembership {
  @override
  Future<MembershipDomain> call() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return const MembershipDomain(category: 'Basic', isSubscribed: false);
  }
}
