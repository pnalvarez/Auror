import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'revision_hub_state.freezed.dart';

@freezed
sealed class RevisionHubState with _$RevisionHubState {
  const factory RevisionHubState({
    @Default(true) bool isLoading,
    @Default(0) int totalMinutes,
    @Default(<RevisionIntroUI>[]) List<RevisionIntroUI> revisions,
    String? errorMessage,
  }) = _RevisionHubState;
}
