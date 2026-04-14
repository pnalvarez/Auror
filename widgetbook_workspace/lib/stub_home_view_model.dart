import 'package:auror/layers/presentation/screens/home/home_event.dart';
import 'package:auror/layers/presentation/screens/home/home_state.dart';
import 'package:auror/layers/presentation/screens/home/idea_ui.dart';
import 'package:auror/layers/presentation/screens/home/revision_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Local [Bloc] for Widgetbook — seeds [HomeState] without API calls.
class StubHomeViewModel extends Bloc<HomeEvent, HomeState> {
  StubHomeViewModel() : super(HomeState()) {
    on<Started>(_onStarted);
  }

  Future<void> _onStarted(Started event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future<void>.delayed(Duration.zero);
    emit(
      state.copyWith(
        isLoading: false,
        userName: 'Alex',
        totalRevisionTime: 45,
        totalTimeToLearnDailyIdea: 30,
        tomorrowRevisions: 3,
        revisions: const [
          RevisionUi(title: 'Spaced repetition', time: '15 min'),
          RevisionUi(title: 'Active recall', time: '20 min'),
          RevisionUi(title: 'Concept mapping', time: '10 min'),
        ],
        dailyIdea: IdeaUi(
          cards: 4,
          totalTime: 120,
          progress: 2,
          total: 6,
        ),
      ),
    );
  }
}
