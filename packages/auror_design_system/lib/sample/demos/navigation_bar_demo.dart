import 'package:auror_design_system/organisms/navigation_bar/ds_navigation_bar.dart';
import 'package:flutter/material.dart';

/// Single [DsNavigationBar] with scrollable page content below the header.
class NavigationBarDemo extends StatelessWidget {
  const NavigationBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DsNavigationBar(
      leadingIcon: Icons.arrow_back,
      title: 'Trilhas',
      description: 'Escolha uma trilha para começar seu aprendizado.',
      trailingIcon: Icons.notifications_outlined,
      onTap: () {},
    );
  }
}
