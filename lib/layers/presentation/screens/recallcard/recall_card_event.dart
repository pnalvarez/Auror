import 'package:freezed_annotation/freezed_annotation.dart';

part 'recall_card_event.freezed.dart';

@freezed
sealed class RecallCardEvent with _$RecallCardEvent {
  const factory RecallCardEvent.practicalExampleExpansionChanged() =
      PracticalExampleExpansionChanged;
  const factory RecallCardEvent.commonErrorExpansionChanged() =
      CommonErrorExpansionChanged;
  const factory RecallCardEvent.proceedButtonTapped() = DidTapProceedCTA;
}
