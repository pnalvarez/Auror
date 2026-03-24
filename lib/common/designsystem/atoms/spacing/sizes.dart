/// Fixed UI dimensions for [auror] (logical pixels): icons, touch targets, bars, avatars.
library;

/// Semantic sizes; pair with [AppSpacings] for padding around these elements.
abstract final class AppSizes {
  AppSizes._();

  // --- Icons ----------------------------------------------------------------
  static const double iconXs = 16;
  static const double iconS = 20;
  static const double iconM = 24;
  static const double iconL = 32;
  static const double iconXl = 40;

  // --- Touch / hit targets (Material minimum 48) -----------------------------
  static const double touchMin = 48;
  static const double touchComfort = 56;

  // --- Avatars --------------------------------------------------------------
  static const double avatarS = 32;
  static const double avatarM = 40;
  static const double avatarL = 48;
  static const double avatarXl = 64;

  // --- Chrome ---------------------------------------------------------------
  static const double appBarHeight = 56;
  static const double bottomNavHeight = 56;
  static const double fabSize = 56;
  static const double dividerThickness = 1;
}
