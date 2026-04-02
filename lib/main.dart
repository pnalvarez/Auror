import 'dart:async';

import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/routes/app_router.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const AurorApp());
}

class AurorApp extends StatefulWidget {
  const AurorApp({super.key});

  @override
  State<AurorApp> createState() => _AurorAppState();
}

class _AurorAppState extends State<AurorApp> {
  static final _appRouter = AppRouter();

  @override
  void reassemble() {
    super.reassemble();
    unawaited(configureDependencies());
  }

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
