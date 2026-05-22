import 'package:auror/common/strings/subscription_upgrade_strings.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_state.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_event.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIGetSubscriptions getSubscriptions;
  late MockISelectSubscription selectSubscription;
  late MockICancelSubscription cancelSubscription;

  setUp(() {
    getSubscriptions = MockIGetSubscriptions();
    selectSubscription = MockISelectSubscription();
    cancelSubscription = MockICancelSubscription();
  });

  blocTest<SubscriptionUpgradeViewModel, SubscriptionUpgradeState>(
    'started sorts subscriptions by price',
    build: () {
      when(getSubscriptions()).thenAnswer(
        (_) async => [
          kFixtureSubscriptionDomain(id: 'b', price: 200, isCurrent: false),
          kFixtureSubscriptionDomain(id: 'a', price: 50, isCurrent: true),
        ],
      );
      return SubscriptionUpgradeViewModel(
        getSubscriptions,
        selectSubscription,
        cancelSubscription,
      );
    },
    act: (bloc) => bloc.add(const SubscriptionUpgradeEvent.started()),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.subscriptions, hasLength(2));
      expect(bloc.state.subscriptions.first.id, 'a');
      expect(bloc.state.subscriptions.last.id, 'b');
      expect(bloc.state.subscriptions.first.price, isNotNull);
    },
  );

  blocTest<SubscriptionUpgradeViewModel, SubscriptionUpgradeState>(
    'select invokes use case',
    build: () {
      when(getSubscriptions()).thenAnswer((_) async => []);
      when(
        selectSubscription.call(id: anyNamed('id')),
      ).thenAnswer((_) async {});
      return SubscriptionUpgradeViewModel(
        getSubscriptions,
        selectSubscription,
        cancelSubscription,
      );
    },
    act: (bloc) async {
      bloc.add(const SubscriptionUpgradeEvent.started());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const SubscriptionUpgradeEvent.selected(id: 'plan-z'));
    },
    verify: (_) {
      verify(selectSubscription(id: 'plan-z')).called(1);
    },
  );

  blocTest<SubscriptionUpgradeViewModel, SubscriptionUpgradeState>(
    'started sets error when load fails',
    build: () {
      when(getSubscriptions()).thenThrow(Exception('net'));
      return SubscriptionUpgradeViewModel(
        getSubscriptions,
        selectSubscription,
        cancelSubscription,
      );
    },
    act: (bloc) => bloc.add(const SubscriptionUpgradeEvent.started()),
    verify: (bloc) {
      expect(bloc.state.errorMessage, contains('net'));
      expect(bloc.state.isLoading, isFalse);
    },
  );

  blocTest<SubscriptionUpgradeViewModel, SubscriptionUpgradeState>(
    'select failure shows error snackbar',
    build: () {
      when(getSubscriptions()).thenAnswer((_) async => []);
      when(selectSubscription(id: anyNamed('id'))).thenThrow(Exception('x'));
      return SubscriptionUpgradeViewModel(
        getSubscriptions,
        selectSubscription,
        cancelSubscription,
      );
    },
    act: (bloc) async {
      bloc.add(const SubscriptionUpgradeEvent.selected(id: 'p'));
    },
    verify: (bloc) {
      expect(bloc.state.snackBarIsError, isTrue);
      expect(bloc.state.shouldNavigateBack, isFalse);
    },
  );

  blocTest<SubscriptionUpgradeViewModel, SubscriptionUpgradeState>(
    'cancel success navigates back',
    build: () {
      when(getSubscriptions()).thenAnswer((_) async => []);
      when(cancelSubscription()).thenAnswer((_) async {});
      return SubscriptionUpgradeViewModel(
        getSubscriptions,
        selectSubscription,
        cancelSubscription,
      );
    },
    act: (bloc) => bloc.add(const SubscriptionUpgradeEvent.cancel()),
    verify: (bloc) {
      expect(bloc.state.shouldNavigateBack, isTrue);
      verify(cancelSubscription()).called(1);
    },
  );

  test('getStyle maps known plan ids', () {
    final vm = SubscriptionUpgradeViewModel(
      MockIGetSubscriptions(),
      MockISelectSubscription(),
      MockICancelSubscription(),
    );
    expect(
      vm.getStyle(subscriptionId: subscriptionUpgradeIdStandard),
      TitleDescriptionCheckpointsInputStyle.standard,
    );
    expect(
      vm.getStyle(subscriptionId: subscriptionUpgradeIdPro),
      TitleDescriptionCheckpointsInputStyle.tertiary,
    );
    expect(
      vm.getStyle(subscriptionId: subscriptionUpgradeIdUltra),
      TitleDescriptionCheckpointsInputStyle.quaternary,
    );
    expect(
      vm.getStyle(subscriptionId: 'unknown'),
      TitleDescriptionCheckpointsInputStyle.standard,
    );
  });
}
