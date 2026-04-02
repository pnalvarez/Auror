import 'package:auror/layers/presentation/screens/dashboard/dashboard_tab_placeholder.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardTabPlaceholder(label: 'Home');
  }
}
