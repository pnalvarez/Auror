import 'package:freezed_annotation/freezed_annotation.dart';

part 'revision_quiz_event.freezed.dart';

@freezed
sealed class RevisionQuizEvent with _$RevisionQuizEvent {
  const factory RevisionQuizEvent.answerDraftChanged(String text) =
      RevisionQuizAnswerDraftChanged;

  const factory RevisionQuizEvent.clearAnswerDraft() =
      RevisionQuizClearAnswerDraft;

  const factory RevisionQuizEvent.deepModeToggled() =
      RevisionQuizDeepModeToggled;

  const factory RevisionQuizEvent.revealAnswer() = RevisionQuizRevealAnswer;

  const factory RevisionQuizEvent.advanceAfterFeedback() =
      RevisionQuizAdvanceAfterFeedback;

  const factory RevisionQuizEvent.shouldPopConsumed() =
      RevisionQuizShouldPopConsumed;

  const factory RevisionQuizEvent.answerSent(String answer) =
      RevisionQuizAnswerSent;
}
