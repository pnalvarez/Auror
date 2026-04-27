import 'package:auror/layers/presentation/screens/home/home_page_body.dart';
import 'package:auror/layers/presentation/screens/home/home_state.dart';
import 'package:auror/layers/presentation/screens/home/idea_ui.dart';
import 'package:auror/layers/presentation/screens/home/revision_ui.dart';
import 'package:auror/layers/presentation/screens/emailconfirmation/email_confirmation_page.dart';
import 'package:auror/layers/presentation/screens/subscriptionupgrade/subscription_upgrade_page.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  path: '[Auror]/[Screens]/Home',
  name: 'With sample data',
  type: HomePageBody,
)
Widget homePageWithSampleData(BuildContext context) {
  return HomePageBody(
    state: HomeState(
      isLoading: false,
      userName: 'Alex',
      revisions: const [
        RevisionUi(title: 'Revisão de conceitos', time: '8 min · Hoje'),
        RevisionUi(title: 'Cartões de recordação', time: '12 min · 4h'),
      ],
      tomorrowRevisions: 3,
      dailyIdea: const IdeaUi(
        cards: 5,
        totalTime: 20,
        progress: 2,
        total: 5,
      ),
      totalTimeToLearnDailyIdea: 15,
      totalRevisionTime: 22,
    ),
    onSeeMoreRevisions: () {},
  );
}

@widgetbook.UseCase(
  path: '[Auror]/[Screens]/Subscription upgrade',
  name: 'Default',
  type: SubscriptionUpgradePage,
)
Widget subscriptionUpgradeDefault(BuildContext context) {
  return const SubscriptionUpgradePage();
}

@widgetbook.UseCase(
  path: '[Auror]/[Screens]/Email confirmation',
  name: 'Default',
  type: EmailConfirmationPage,
)
Widget emailConfirmationDefault(BuildContext context) {
  return const EmailConfirmationPage(email: 'demo@gmail.com');
}
