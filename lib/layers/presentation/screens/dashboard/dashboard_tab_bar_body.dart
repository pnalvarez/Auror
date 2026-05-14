import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Bottom tab bar for [DashboardPage] (no [AutoTabsRouter]).
class DashboardTabBarBody extends StatelessWidget {
  const DashboardTabBarBody({
    super.key,
    required this.scheme,
    required this.specs,
    required this.selectedIndex,
    required this.onSelectIndex,
  });

  final ColorScheme scheme;
  final List<DashboardTabSpec> specs;
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

class DashboardTabSpec {
  const DashboardTabSpec({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class _TabBarItem extends StatelessWidget {
  const _TabBarItem({
    required this.spec,
    required this.selected,
    required this.scheme,
    required this.onTap,
  });

  final DashboardTabSpec spec;
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
