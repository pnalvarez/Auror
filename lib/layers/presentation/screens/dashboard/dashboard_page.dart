import 'package:auror/common/strings/dashboard_strings.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auror/layers/presentation/screens/dashboard/dashboard_tab_bar_body.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const _tabs = <DashboardTabSpec>[
    DashboardTabSpec(label: home, icon: Icons.home_outlined),
    DashboardTabSpec(label: revisions, icon: Icons.psychology_outlined),
    DashboardTabSpec(label: explore, icon: Icons.explore_outlined),
    DashboardTabSpec(label: routes, icon: Icons.route_outlined),
    DashboardTabSpec(label: profile, icon: Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: AutoTabsRouter(
        routes: const [
          DashboardHomeRoute(),
          DashboardRevisionHubRoute(),
          DashboardExploreRoute(),
          DashboardRoutesRoute(),
          DashboardProfileRoute(),
        ],
        navigatorObservers: () => [AutoRouteObserver()],
        transitionBuilder: (context, child, animation) =>
            FadeTransition(opacity: animation, child: child),
        builder: (context, child) {
          final router = context.tabsRouter;
          final scheme = Theme.of(context).colorScheme;
          return Scaffold(
            backgroundColor: scheme.surface,
            body: Column(
              children: [
                Expanded(child: child),
                DashboardTabBarBody(
                  scheme: scheme,
                  specs: _tabs,
                  selectedIndex: router.activeIndex,
                  onSelectIndex: router.setActiveIndex,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
