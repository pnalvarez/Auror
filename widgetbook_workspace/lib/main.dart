import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

/// Opens the first DS use case on launch so the canvas is not empty (otherwise
/// Widgetbook shows [DefaultHomePage] until you pick a leaf in the nav tree).
final Uri _widgetbookInitialUri = Uri(
  path: '/',
  queryParameters: {'path': 'auror/screens/home/homepagebody/with-sample-data'},
);

/// Same [ThemeData] as [MaterialApp.router] in `auror/lib/main.dart`.
final ThemeData _aurorAppTheme = ThemeData(
  colorScheme: AppColors.lightColorScheme,
  useMaterial3: true,
);

/// Widgetbook’s default [materialAppBuilder] nests a second [MaterialApp] with no
/// [ThemeData], so previews used Flutter’s default colors. This mirrors the main
/// app: one ambient [Theme] + [Material] for ink/splash.
Widget _aurorAppBuilder(BuildContext context, Widget child) {
  return Theme(
    data: _aurorAppTheme,
    child: Material(
      color: _aurorAppTheme.colorScheme.surface,
      child: child,
    ),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(
    Widgetbook.material(
      initialRoute: _widgetbookInitialUri.toString(),
      directories: directories,
      themeMode: ThemeMode.light,
      lightTheme: _aurorAppTheme,
      darkTheme: _aurorAppTheme,
      appBuilder: _aurorAppBuilder,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Auror (light)', data: _aurorAppTheme),
          ],
        ),
      ],
    ),
  );
}

@widgetbook.App()
class WidgetbookApp {}
