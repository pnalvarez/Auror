import 'package:auror/layers/domain/models/revision_section_domain.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_state.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_event.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIGetRevisions getRevisions;

  setUp(() {
    getRevisions = MockIGetRevisions();
  });

  blocTest<RevisionHubViewModel, RevisionHubState>(
    'load requested maps revisions to UI models',
    build: () {
      final rev = kFixtureRevision();
      when(getRevisions()).thenAnswer(
        (_) async => RevisionSectionDomain(
          tomorrowCount: 1,
          revisions: [rev],
        ),
      );
      return RevisionHubViewModel(getRevisions);
    },
    act: (bloc) => bloc.add(const RevisionHubLoadRequested()),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.revisions, hasLength(1));
      expect(bloc.state.totalMinutes, 5);
      expect(bloc.revisions, hasLength(1));
    },
  );

  blocTest<RevisionHubViewModel, RevisionHubState>(
    'load failure clears revisions',
    build: () {
      when(getRevisions()).thenThrow(Exception('err'));
      return RevisionHubViewModel(getRevisions);
    },
    act: (bloc) => bloc.add(const RevisionHubLoadRequested()),
    verify: (bloc) {
      expect(bloc.state.revisions, isEmpty);
      expect(bloc.state.errorMessage, contains('err'));
    },
  );
}
