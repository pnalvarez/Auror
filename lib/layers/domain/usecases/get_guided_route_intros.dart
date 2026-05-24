import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';
import 'package:auror/layers/domain/repository/guided_route_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IGetGuidedRouteIntros {
  Future<List<GuidedRouteIntroDomain>> call();
}

@Injectable(as: IGetGuidedRouteIntros)
class GetGuidedRouteIntros implements IGetGuidedRouteIntros {
  GetGuidedRouteIntros(this._repository);

  final IGuidedRouteRepository _repository;

  @override
  Future<List<GuidedRouteIntroDomain>> call() =>
      _repository.getGuidedRoutes();
}
