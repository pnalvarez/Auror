import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_event.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_state.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockIHasActiveSession hasActiveSession;

  setUp(() {
    hasActiveSession = MockIHasActiveSession();
  });

  MainLaunchViewModel buildSut() => MainLaunchViewModel(hasActiveSession);

  blocTest<MainLaunchViewModel, MainLaunchState>(
    'started emits loading then ready without session',
    build: buildSut,
    setUp: () => when(hasActiveSession.call()).thenReturn(false),
    act: (bloc) => bloc.add(const MainLaunchEvent.started()),
    expect: () => const <MainLaunchState>[
      MainLaunchState.loading(),
      MainLaunchState.ready(hasActiveSession: false),
    ],
  );

  blocTest<MainLaunchViewModel, MainLaunchState>(
    'started restores session and schedules dashboard navigation',
    build: buildSut,
    setUp: () => when(hasActiveSession.call()).thenReturn(true),
    act: (bloc) => bloc.add(const MainLaunchEvent.started()),
    expect: () => const <MainLaunchState>[
      MainLaunchState.loading(),
      MainLaunchState.ready(
        hasActiveSession: true,
        pendingDashboardNavigation: true,
      ),
    ],
  );

  blocTest<MainLaunchViewModel, MainLaunchState>(
    'enter app with session schedules dashboard navigation',
    build: buildSut,
    seed: () => const MainLaunchState.ready(hasActiveSession: true),
    act: (bloc) => bloc.add(const MainLaunchEvent.enterAppTapped()),
    expect: () => const <MainLaunchState>[
      MainLaunchState.ready(
        hasActiveSession: true,
        pendingDashboardNavigation: true,
      ),
    ],
  );

  blocTest<MainLaunchViewModel, MainLaunchState>(
    'enter app without session does not change state',
    build: buildSut,
    seed: () => const MainLaunchState.ready(hasActiveSession: false),
    act: (bloc) => bloc.add(const MainLaunchEvent.enterAppTapped()),
    expect: () => <MainLaunchState>[],
  );

  blocTest<MainLaunchViewModel, MainLaunchState>(
    'dashboard navigation consumed clears pending flag',
    build: buildSut,
    seed: () => const MainLaunchState.ready(
      hasActiveSession: true,
      pendingDashboardNavigation: true,
    ),
    act: (bloc) =>
        bloc.add(const MainLaunchEvent.dashboardNavigationConsumed()),
    expect: () => const <MainLaunchState>[
      MainLaunchState.ready(hasActiveSession: true),
    ],
  );

  blocTest<MainLaunchViewModel, MainLaunchState>(
    'how it works event is handled without state change',
    build: buildSut,
    act: (bloc) => bloc.add(const MainLaunchEvent.howItWorksTapped()),
    expect: () => <MainLaunchState>[],
  );
}
