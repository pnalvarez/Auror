import 'package:auror/layers/domain/models/revision_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'revision_hub_ui.freezed.dart';

/// Presentation row for a pending revision, mapped from [RevisionDomain].
@freezed
sealed class RevisionIntroUI with _$RevisionIntroUI {
  const RevisionIntroUI._();

  const factory RevisionIntroUI({
    required String title,
    required String minutes,
  }) = _RevisionIntroUI;

  factory RevisionIntroUI.fromDomain(RevisionDomain domain) {
    return RevisionIntroUI(
      title: domain.question,
      minutes: '${domain.minutes} min',
    );
  }
}
