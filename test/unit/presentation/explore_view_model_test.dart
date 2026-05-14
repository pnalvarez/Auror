import 'package:auror/common/strings/explore_strings.dart';
import 'package:auror/layers/domain/models/category_domain.dart';
import 'package:auror/layers/presentation/screens/explore/explore_state.dart';
import 'package:auror/layers/presentation/screens/explore/explore_event.dart';
import 'package:auror/layers/presentation/screens/explore/explore_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIGetCategories getCategories;
  late MockIGetNextCard getNextCard;

  setUp(() {
    getCategories = MockIGetCategories();
    getNextCard = MockIGetNextCard();
  });

  blocTest<ExploreViewModel, ExploreState>(
    'started loads categories and first card',
    build: () {
      when(getCategories()).thenAnswer(
        (_) async => const [
          CategoryDomain(id: 'c1', name: 'One'),
        ],
      );
      when(getNextCard()).thenAnswer((_) async => kFixtureKnowledgeCard);
      return ExploreViewModel(getCategories, getNextCard);
    },
    act: (bloc) => bloc.add(const ExploreEvent.started()),
    wait: const Duration(milliseconds: 200),
    verify: (bloc) {
      expect(bloc.state.isLoadingInitial, isFalse);
      expect(bloc.state.chipLabels.first, exploreChipAll);
      expect(bloc.state.cardSlots.first, kFixtureKnowledgeCard);
      verify(getCategories()).called(1);
      verify(getNextCard()).called(1);
    },
  );

  blocTest<ExploreViewModel, ExploreState>(
    'started sets error when categories fail',
    build: () {
      when(getCategories()).thenThrow(Exception('net'));
      return ExploreViewModel(getCategories, getNextCard);
    },
    act: (bloc) => bloc.add(const ExploreEvent.started()),
    verify: (bloc) {
      expect(bloc.state.errorMessage, exploreLoadError);
      expect(bloc.state.isLoadingInitial, isFalse);
    },
  );
}
