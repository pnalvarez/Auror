import 'package:auror/layers/data/datasource/api_data_source.dart';
import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';
import 'package:auror/layers/domain/repository/guided_route_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IGuidedRouteRepository)
class GuidedRouteRepository implements IGuidedRouteRepository {
  GuidedRouteRepository(this._apiDataSource);

  final IApiDataSource _apiDataSource;

  @override
  Future<List<GuidedRouteIntroDomain>> getGuidedRoutes() async {
    final rows = await _apiDataSource.fetchGuidedRoutes();
    return rows.map((data) => data.toDomain()).toList();
  }
}
