import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/layers/presentation/routes/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AurorApp());
}

class AurorApp extends StatelessWidget {
  const AurorApp({super.key});

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Auror',
      theme: ThemeData(
        colorScheme: AppColors.lightColorScheme,
        useMaterial3: true,
      ),
    );
  }
}
