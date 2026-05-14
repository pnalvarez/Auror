import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_event.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_state.dart';
import 'package:auror/layers/presentation/screens/mainlaunch/main_launch_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest<MainLaunchViewModel, MainLaunchState>(
    'started emits loading then ready without session',
    build: MainLaunchViewModel.new,
    act: (bloc) => bloc.add(const MainLaunchEvent.started()),
    wait: const Duration(milliseconds: 600),
    expect: () => const <MainLaunchState>[
      MainLaunchState.loading(),
      MainLaunchState.ready(hasActiveSession: false),
    ],
  );
}
