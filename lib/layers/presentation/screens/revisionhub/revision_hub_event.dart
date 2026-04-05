import 'package:freezed_annotation/freezed_annotation.dart';

part 'revision_hub_event.freezed.dart';

@freezed
sealed class RevisionHubEvent with _$RevisionHubEvent {
  const factory RevisionHubEvent.loadRequested() = RevisionHubLoadRequested;
}
