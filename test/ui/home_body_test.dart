import 'package:auror/common/strings/home_strings.dart';
import 'package:auror/layers/presentation/screens/home/home_body.dart';
import 'package:auror/layers/presentation/screens/home/revision_ui.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomeBody shows loader when loading', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: HomeBody(
            isLoading: true,
            userName: '',
            totalRevisionTime: 0,
            totalTimeToLearnDailyIdea: 0,
            revisions: const [],
            tomorrowRevisionsCount: 0,
            dailyIdeaCards: 0,
            dailyIdeaProgress: 0,
            dailyIdeaTotal: 1,
            onDailyIdeaCtaTap: () {},
            onSeeMoreRevisions: () {},
          ),
        ),
      ),
    );
    expect(find.byType(CircularLoader), findsOneWidget);
  });

  testWidgets('HomeBody shows greeting and invokes daily idea CTA', (
    tester,
  ) async {
    var dailyTaps = 0;
    var moreTaps = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: mainLaunchDarkTheme(),
        home: Scaffold(
          body: HomeBody(
            isLoading: false,
            userName: 'Ana',
            totalRevisionTime: 10,
            totalTimeToLearnDailyIdea: 5,
            revisions: const [
              RevisionUi(title: 'R1', time: '10 min'),
            ],
            tomorrowRevisionsCount: 2,
            dailyIdeaCards: 3,
            dailyIdeaProgress: 1,
            dailyIdeaTotal: 4,
            onDailyIdeaCtaTap: () => dailyTaps++,
            onSeeMoreRevisions: () => moreTaps++,
          ),
        ),
      ),
    );

    expect(find.text(homeGreeting('Ana')), findsOneWidget);
    expect(find.text(homeDailyIdeaCta), findsOneWidget);
    await tester.tap(find.text(homeDailyIdeaCta));
    expect(dailyTaps, 1);

    await tester.tap(find.text(seeMore));
    expect(moreTaps, 1);
  });
}
