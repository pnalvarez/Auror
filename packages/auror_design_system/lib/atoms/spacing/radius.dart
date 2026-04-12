/// Corner radii for [auror] (logical pixels).
library;

/// Shape corners; values follow the same rhythm as [AppSpacings] up through 32.
abstract final class AppRadius {
  AppRadius._();

  static const double none = 0;
  static const double xs4 = 1;
  static const double xs2 = 2;
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 20;
  static const double xl2 = 24;
  static const double xl3 = 32;

  /// Half of [side] — circular pill when width/height equal [side].
  static double full(double side) => side / 2;
}
