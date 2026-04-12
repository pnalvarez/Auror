# auror_design_system

Flutter UI kit extracted from the Auror app: color tokens, typography (Poppins), spacing, and composed widgets (badges, buttons, list items, cards, etc.), plus optional on-device demo screens (`sample/`).

## Use in another Flutter app

1. Copy or submodule this folder, or depend on it from a monorepo path.

2. In your app `pubspec.yaml`:

```yaml
dependencies:
  auror_design_system:
    path: packages/auror_design_system  # adjust relative path
```

3. Ensure **Poppins** is available: this package declares the same font assets under `fonts/`. With `google_fonts`, you may set `GoogleFonts.config.allowRuntimeFetching` to match your app.

4. Import what you need:

```dart
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
```

The gallery routes that use **AutoRoute** stay in the host app; only components and `DsDemoCatalog` live here.
