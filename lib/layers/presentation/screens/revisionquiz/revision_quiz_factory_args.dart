import 'package:auror/layers/domain/models/idea_track_flow_args.dart';

/// Second [factoryParam] for [RevisionQuizViewModel] (GetIt supports at most two).
class RevisionQuizFactoryArgs {
  const RevisionQuizFactoryArgs({
    this.cardId,
    this.ideaTrackFlow,
  });

  final String? cardId;
  final IdeaTrackFlowArgs? ideaTrackFlow;
}
