import 'package:auror/layers/presentation/screens/guidedrouteshub/guided_routes_hub_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardRoutesPage extends StatelessWidget {
  const DashboardRoutesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GuidedRoutesHubPage();
  }
}
