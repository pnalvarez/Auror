import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_launch_event.freezed.dart';

@freezed
sealed class MainLaunchEvent with _$MainLaunchEvent {
  const factory MainLaunchEvent.started() = MainLaunchStarted;

  const factory MainLaunchEvent.enterAppTapped() = MainLaunchEnterAppTapped;

  const factory MainLaunchEvent.howItWorksTapped() = MainLaunchHowItWorksTapped;
}
