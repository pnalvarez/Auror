import 'package:auror/common/strings/main_launch_strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('main launch copy constants are non-empty', () {
    expect(badgePill, isNotEmpty);
    expect(ctaEnterApp, isNotEmpty);
  });
}
