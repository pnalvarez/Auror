import 'package:freezed_annotation/freezed_annotation.dart';

part 'recall_card_event.freezed.dart';

@freezed
sealed class RecallCardEvent with _$RecallCardEvent {
  const factory RecallCardEvent.practicalExampleExpansionChanged({
    required bool expanded,
  }) = PracticalExampleExpansionChanged;
  const factory RecallCardEvent.commonErrorExpansionChanged({
    required bool expanded,
  }) = CommonErrorExpansionChanged;
  const factory RecallCardEvent.proceedCtaViewportVisibilityChanged({
    required bool isVisible,
  }) = ProceedCtaViewportVisibilityChanged;
  const factory RecallCardEvent.proceedButtonTapped() = DidTapProceedCTA;
}
