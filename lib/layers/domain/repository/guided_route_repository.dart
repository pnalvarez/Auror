import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';
import 'package:auror/layers/domain/models/guided_route_overview_domain.dart';
import 'package:auror/layers/domain/models/knowledge_card_domain.dart';

abstract class IGuidedRouteRepository {
  Future<List<GuidedRouteIntroDomain>> getGuidedRoutes();

  Future<GuidedRouteOverviewDomain> fetchOverview({
    required String guidedRouteId,
  });

  Future<List<KnowledgeCardDomain>> fetchKnowledgeCards({
    required String submoduleId,
  });
}
