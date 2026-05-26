import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/domain/repository/guided_route_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IGetKnowledgeCards {
  Future<List<KnowledgeCardDomain>> call({required String submoduleId});
}

@Injectable(as: IGetKnowledgeCards)
class GetKnowledgeCards implements IGetKnowledgeCards {
  GetKnowledgeCards(this._repository);

  final IGuidedRouteRepository _repository;

  @override
  Future<List<KnowledgeCardDomain>> call({required String submoduleId}) =>
      _repository.fetchKnowledgeCards(submoduleId: submoduleId);
}
