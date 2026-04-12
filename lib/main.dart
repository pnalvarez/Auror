import 'dart:async';

import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror/core/di/di.dart';
import 'package:auror/layers/presentation/routes/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fvp/fvp.dart' as fvp;
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // [video_player] has no first-party Windows/Linux implementation. [fvp] supplies
  // those. macOS uses stock AVFoundation (do not register [fvp] there: it expects
  // fvp.framework to be embedded and will crash at load if missing).
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux)) {
    fvp.registerWith(
      options: <String, dynamic>{
        'platforms': <String>['windows', 'linux'],
      },
    );
  }
  // Use Poppins from [pubspec.yaml] instead of fetching from fonts.gstatic.com.
  GoogleFonts.config.allowRuntimeFetching = false;
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
