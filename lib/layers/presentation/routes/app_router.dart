import 'package:auto_route/auto_route.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Tab|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainLaunchRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: DsMenuSampleRoute.page),
    AutoRoute(page: DSComponentRoute.page),
    AutoRoute(page: OnboardingLearningLoopRoute.page),
    AutoRoute(page: OnboardingGuidedRoutesRoute.page),
    AutoRoute(page: OnboardingLearningSectionRoute.page),
    AutoRoute(page: OnboardingRealExampleRoute.page),
  ];
}
