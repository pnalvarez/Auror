import 'package:auror/layers/domain/usecases/get_daily_idea.dart';
import 'package:auror/layers/domain/usecases/get_revisions.dart';
import 'package:auror/layers/domain/usecases/get_user.dart';
import 'package:auror/layers/presentation/screens/home/home_event.dart';
import 'package:auror/layers/presentation/screens/home/home_state.dart';
import 'package:auror/layers/presentation/screens/home/idea_ui.dart';
import 'package:auror/layers/presentation/screens/home/revision_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

const _kDailyIdeaTrackCardCount = 3;

@injectable
class HomeViewModel extends Bloc<HomeEvent, HomeState> {
  HomeViewModel({
    required IGetUser getUser,
    required IGetRevisions getRevisions,
    required IGetDailyIdea getDailyIdea,
  }) : _getUser = getUser,
       _getRevisions = getRevisions,
       _getDailyIdea = getDailyIdea,
       super(HomeState()) {
    on<Started>(_onStarted);
  }

  final IGetUser _getUser;
  final IGetRevisions _getRevisions;
  final IGetDailyIdea _getDailyIdea;

  Future<void> _onStarted(Started event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final user = await _getUser();
      final revisionSection = await _getRevisions();
      final dailyIdea = await _getDailyIdea();
      final ideaTrack = dailyIdea.incompleteCards
          .take(_kDailyIdeaTrackCardCount)
          .toList(growable: false);

      emit(
        state.copyWith(
          userName: user.name,
          revisions: revisionSection.revisions
              .map(
                (revision) => RevisionUi(
                  title: revision.title,
                  time: '${revision.minutes} min',
                ),
              )
              .toList(),
          dailyIdea: IdeaUi(
            cards: dailyIdea.completedCards.length,
            totalTime: dailyIdea.totalTime,
            progress: dailyIdea.completedCards.length,
            total:
                dailyIdea.completedCards.length +
                dailyIdea.incompleteCards.length,
          ),
          totalTimeToLearnDailyIdea: dailyIdea.totalTime,
          totalRevisionTime: revisionSection.revisions.fold<int>(
            0,
            (sum, r) => sum + r.minutes,
          ),
          dailyIdeaTrackCards: ideaTrack,
          isLoading: false,
        ),
      );
    } catch (e) {
      // Handle error state
      emit(state.copyWith(isLoading: false));
    }
  }
}
