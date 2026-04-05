import 'package:auror/layers/domain/models/revision_domain.dart';
import 'package:auror/layers/domain/usecases/revision_mock_data.dart';
import 'package:injectable/injectable.dart';

abstract class IGetRevisions {
  Future<List<RevisionDomain>> call();
}

@Injectable(as: IGetRevisions)
class GetRevisions implements IGetRevisions {
  @override
  Future<List<RevisionDomain>> call() async {
    await Future<void>.delayed(const Duration(milliseconds: 280));
    return List<RevisionDomain>.unmodifiable(kMockRevisionDomains);
  }
}
