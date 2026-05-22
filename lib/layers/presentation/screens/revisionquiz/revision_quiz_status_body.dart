import 'package:auror/common/strings/revision_quiz_strings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:flutter/material.dart';

/// Loading state for [RevisionQuizPage].
class RevisionQuizLoadingBody extends StatelessWidget {
  const RevisionQuizLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(child: CircularLoader(color: scheme.primary));
  }
}

/// No revisions available for [RevisionQuizPage].
class RevisionQuizEmptyBody extends StatelessWidget {
  const RevisionQuizEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Text(
        revisionQuizEmptyMessage,
        style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
      ),
    );
  }
}
