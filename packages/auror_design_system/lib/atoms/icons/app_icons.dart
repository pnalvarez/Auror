/// SVG icon asset paths bundled in [auror_design_system].
abstract final class AppIcons {
  static const package = 'auror_design_system';

  static const String successCheckCircle =
      'assets/icons/ic_success_check_circle.svg';

  static const String lockedCircle = 'assets/icons/ic_locked_circle.svg';

  static const List<({String name, String asset})> catalog = [
    (name: 'AppIcons.successCheckCircle', asset: successCheckCircle),
    (name: 'AppIcons.lockedCircle', asset: lockedCircle),
  ];
}
