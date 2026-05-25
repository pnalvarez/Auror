import 'package:auror/layers/domain/models/guided_route_overview_domain.dart';
import 'package:auror/layers/domain/repository/guided_route_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IGetGuidedRouteOverviewDetails {
  Future<GuidedRouteOverviewDomain> call({required String guidedRouteId});
}

@Injectable(as: IGetGuidedRouteOverviewDetails)
class GetGuidedRouteOverviewDetails implements IGetGuidedRouteOverviewDetails {
  GetGuidedRouteOverviewDetails(this._repository);

  final IGuidedRouteRepository _repository;

  @override
  Future<GuidedRouteOverviewDomain> call({required String guidedRouteId}) =>
      _repository.fetchOverview(guidedRouteId: guidedRouteId);
}
