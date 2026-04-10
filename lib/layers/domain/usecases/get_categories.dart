import 'package:auror/layers/domain/models/category_domain.dart';
import 'package:injectable/injectable.dart';

abstract class IGetCategories {
  Future<List<CategoryDomain>> call();
}

@Injectable(as: IGetCategories)
class GetCategories implements IGetCategories {
  @override
  Future<List<CategoryDomain>> call() async {
    return const [
      CategoryDomain(id: 'personal_development', name: 'Desenvolvimento Pessoal'),
      CategoryDomain(id: 'productivity', name: 'Produtividade'),
      CategoryDomain(id: 'communication', name: 'Comunicação'),
    ];
  }
}
