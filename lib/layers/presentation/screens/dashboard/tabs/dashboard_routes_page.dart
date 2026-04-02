import 'package:auror/layers/presentation/screens/dashboard/dashboard_tab_placeholder.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardRoutesPage extends StatelessWidget {
  const DashboardRoutesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardTabPlaceholder(label: 'Rotas');
  }
}
