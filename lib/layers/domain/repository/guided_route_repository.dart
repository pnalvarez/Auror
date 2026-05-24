import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';

abstract class IGuidedRouteRepository {
  Future<List<GuidedRouteIntroDomain>> getGuidedRoutes();
}
