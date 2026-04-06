import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_event.freezed.dart';

@freezed
sealed class ExploreEvent with _$ExploreEvent {
  const factory ExploreEvent.started() = ExploreStarted;

  const factory ExploreEvent.chipSelected(int index) = ExploreChipSelected;

  /// Fired when a page becomes visible (swipe or programmatic).
  const factory ExploreEvent.pageBecameVisible(int index) =
      ExplorePageBecameVisible;
}
