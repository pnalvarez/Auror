import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:auror/common/strings/dashboard_strings.dart';
import 'package:auror/layers/presentation/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const _tabs = <_DashboardTabSpec>[
    _DashboardTabSpec(label: home, icon: Icons.home_outlined),
    _DashboardTabSpec(label: revisions, icon: Icons.psychology_outlined),
    _DashboardTabSpec(label: explore, icon: Icons.explore_outlined),
    _DashboardTabSpec(label: routes, icon: Icons.route_outlined),
    _DashboardTabSpec(label: profile, icon: Icons.person_outline),
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
                _DashboardBottomBar(
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

class _DashboardTabSpec {
  const _DashboardTabSpec({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class _DashboardBottomBar extends StatelessWidget {
  const _DashboardBottomBar({
    required this.scheme,
    required this.specs,
    required this.selectedIndex,
    required this.onSelectIndex,
  });

  final ColorScheme scheme;
  final List<_DashboardTabSpec> specs;
  final int selectedIndex;
  final ValueChanged<int> onSelectIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: scheme.surfaceContainerHigh,
      elevation: 0,
      child: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final segmentW = constraints.maxWidth / specs.length;
              return Row(
                children: [
                  for (var i = 0; i < specs.length; i++)
                    SizedBox(
                      width: segmentW,
                      child: _TabBarItem(
                        spec: specs[i],
                        selected: selectedIndex == i,
                        scheme: scheme,
                        onTap: () => onSelectIndex(i),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TabBarItem extends StatelessWidget {
  const _TabBarItem({
    required this.spec,
    required this.selected,
    required this.scheme,
    required this.onTap,
  });

  final _DashboardTabSpec spec;
  final bool selected;
  final ColorScheme scheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.Inverse.inversePrimary;
    final color = selected ? accent : scheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(spec.icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              spec.label,
              style: body4Light.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
