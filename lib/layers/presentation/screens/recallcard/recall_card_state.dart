import 'package:freezed_annotation/freezed_annotation.dart';

part 'recall_card_state.freezed.dart';

@freezed
sealed class RecallCardState with _$RecallCardState {
  const factory RecallCardState({
    @Default(false) bool isProceedCTAEnabled,
    @Default(false) bool isLoading,
    @Default(false) bool shouldRedirectTorRevisionQuiz,
    @Default(false) bool shouldDisplayErrorMessage,
    @Default(true) bool shouldDisplayPracticalExampleTooltip,
    @Default(false) bool shouldDisplayCommonErrorTooltip,
    @Default(false) bool isCommonErrorDropdownEnabled,
    @Default(false) bool shouldFloatingButtonAppear,
  }) = _RecallCardState;
}
