import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:auror/layers/presentation/screens/home/idea_ui.dart';
import 'package:auror/layers/presentation/screens/home/revision_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<RevisionUi> revisions,
    @Default(null) IdeaUi? dailyIdea,
    @Default(null) int? totalTimeToLearnDailyIdea,
    @Default(null) int? totalRevisionTime,
    @Default(true) bool isLoading,
    @Default(null) String? userName,
    @Default(null) int? tomorrowRevisions,
    @Default(<KnowledgeCardDomain>[])
    List<KnowledgeCardDomain> dailyIdeaTrackCards,
  }) = _HomeState;
}
