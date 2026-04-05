import 'package:auror/layers/presentation/screens/revisionhub/revision_hub_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardRevisionHubPage extends StatelessWidget {
  const DashboardRevisionHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RevisionHubPage();
  }
}
