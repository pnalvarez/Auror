import 'package:auror/layers/domain/models/revision_domain.dart';
import 'package:auror/layers/domain/models/revision_section_domain.dart';
import 'package:auror/layers/domain/usecases/revision_mock_data.dart';
import 'package:injectable/injectable.dart';

abstract class IGetRevisions {
  Future<RevisionSectionDomain> call();
}

@Injectable(as: IGetRevisions)
class GetRevisions implements IGetRevisions {
  @override
  Future<RevisionSectionDomain> call() async {
    await Future<void>.delayed(const Duration(milliseconds: 280));
    return RevisionSectionDomain(
      tomorrowCount: 1,
      revisions: List<RevisionDomain>.unmodifiable(kMockRevisionDomains),
    );
  }
}
