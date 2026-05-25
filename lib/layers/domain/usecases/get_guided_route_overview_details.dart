import 'package:auror/layers/domain/models/guided_route_overview_domain.dart';
import 'package:auror/layers/domain/usecases/guided_route_overview_mock_data.dart';
import 'package:injectable/injectable.dart';

abstract class IGetGuidedRouteOverviewDetails {
  Future<GuidedRouteOverviewDomain> call();
}

@Injectable(as: IGetGuidedRouteOverviewDetails)
class GetGuidedRouteOverviewDetails implements IGetGuidedRouteOverviewDetails {
  @override
  Future<GuidedRouteOverviewDomain> call() async {
    return kMockGuidedRouteOverviewDomain;
  }
}
