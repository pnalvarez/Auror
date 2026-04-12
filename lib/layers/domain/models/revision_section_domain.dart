import 'package:auror/layers/domain/models/revision_domain.dart';

class RevisionSectionDomain {
  RevisionSectionDomain({required this.tomorrowCount, required this.revisions});
  final int tomorrowCount;
  final List<RevisionDomain> revisions;
}
