import 'package:auror/layers/domain/models/revision_domain.dart';
import 'package:auror/layers/presentation/screens/revisionquiz/revision_quiz_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'revision_quiz_state.freezed.dart';

@freezed
sealed class RevisionQuizState with _$RevisionQuizState {
  const factory RevisionQuizState({
    @Default(false) bool isRevisionTrack,
    required List<RevisionDomain> allRevisions,
    @Default(null) RevisionQuizUI? currentRevision,
    @Default(0) int currentIndex,
    @Default(false) bool deepMode,
    @Default(false) bool answerRevealed,
    @Default(false) bool isSendAnswerCTAEnabled,
    @Default(false) bool shouldPopRoute,
    @Default(false) bool shouldShowAnswerSentDisclaimer,
    @Default(true) bool deepModeCTAEnabled,
    @Default(true) bool revealAnswerCTAEnabled,
    @Default(true) bool isLoading,
  }) = _RevisionQuizState;
}
