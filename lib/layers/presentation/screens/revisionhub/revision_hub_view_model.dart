import 'package:auror/layers/domain/models/revision_domain.dart';
import 'package:auror/layers/domain/usecases/get_revisions.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_event.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_state.dart';
import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RevisionHubViewModel extends Bloc<RevisionHubEvent, RevisionHubState> {
  RevisionHubViewModel(this._getPendingRevisions)
    : super(const RevisionHubState()) {
    on<RevisionHubLoadRequested>(_onLoadRequested);
  }

  final IGetRevisions _getPendingRevisions;
  List<RevisionDomain> revisions = [];

  Future<void> _onLoadRequested(
    RevisionHubLoadRequested event,
    Emitter<RevisionHubState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final domainList = await _getPendingRevisions();
      this.revisions = domainList;
      final revisions = domainList
          .map(RevisionIntroUI.fromDomain)
          .toList(growable: false);
      emit(
        state.copyWith(
          isLoading: false,
          totalMinutes: domainList.fold<int>(0, (sum, r) => sum + r.minutes),
          revisions: revisions,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          revisions: [],
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
