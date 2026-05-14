import 'package:auror/layers/presentation/screens/recallcard/recall_card_state.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_event.dart';
import 'package:auror/layers/presentation/screens/recallcard/recall_card_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late MockISaveRecallCard saveRecallCard;

  setUp(() {
    saveRecallCard = MockISaveRecallCard();
  });

  blocTest<RecallCardViewModel, RecallCardState>(
    'proceed tap saves card and sets redirect flag',
    build: () {
      when(
        saveRecallCard.call(cardId: anyNamed('cardId')),
      ).thenAnswer((_) async {});
      return RecallCardViewModel(kFixtureKnowledgeCard, saveRecallCard);
    },
    act: (bloc) => bloc.add(const RecallCardEvent.proceedButtonTapped()),
    verify: (bloc) {
      verify(saveRecallCard(cardId: kFixtureKnowledgeCard.id)).called(1);
      expect(bloc.state.shouldRedirectTorRevisionQuiz, isTrue);
      expect(bloc.state.isLoading, isFalse);
    },
  );
}
