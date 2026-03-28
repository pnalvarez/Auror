/// Compile-time environment flags ([bool.fromEnvironment] / [String.fromEnvironment]).
///
/// **Production builds** should pass `--dart-define=PRODUCTION=true` so dev-only UI
/// (e.g. design system entry from the launch screen) is stripped from release binaries.
///
/// **Local / dev:** omit the flag (default is non-production).
library;

abstract final class AppEnvironment {
  AppEnvironment._();

  /// `true` when built with `--dart-define=PRODUCTION=true`.
  static const bool production = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );

  /// Design system catalog and similar dev-only affordances.
  static bool get showDesignSystemCatalog => !production;
}
