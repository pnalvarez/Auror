import 'package:auto_route/auto_route.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Tab|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainLaunchRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RevisionQuizRoute.page),
    AutoRoute(page: RecallCardRoute.page),
    AutoRoute(page: SuccessRoute.page),
    AutoRoute(
      page: DashboardRoute.page,
      children: [
        AutoRoute(page: DashboardHomeRoute.page, path: 'home'),
        AutoRoute(page: DashboardRevisionHubRoute.page, path: 'revisions'),
        AutoRoute(page: DashboardExploreRoute.page, path: 'explore'),
        AutoRoute(page: DashboardRoutesRoute.page, path: 'routes'),
        AutoRoute(page: DashboardProfileRoute.page, path: 'profile'),
      ],
    ),
    AutoRoute(page: DsMenuSampleRoute.page),
    AutoRoute(page: DSComponentRoute.page),
    AutoRoute(page: OnboardingLearningLoopRoute.page),
    AutoRoute(page: OnboardingGuidedRoutesRoute.page),
    AutoRoute(page: OnboardingLearningSectionRoute.page),
    AutoRoute(page: OnboardingRealExampleRoute.page),
    AutoRoute(page: SubscriptionUpgradeRoute.page),
  ];
}
