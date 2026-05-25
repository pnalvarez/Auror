import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';
import 'package:auror/layers/domain/models/guided_route_overview_domain.dart';

abstract class IGuidedRouteRepository {
  Future<List<GuidedRouteIntroDomain>> getGuidedRoutes();

  Future<GuidedRouteOverviewDomain> fetchOverview({
    required String guidedRouteId,
  });
}
