import 'package:auror/common/strings/main_launch_strings.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auror/main.dart';

void main() {
  testWidgets('App boots on main launch', (WidgetTester tester) async {
    await tester.pumpWidget(const AurorApp());
    await tester.pumpAndSettle();

    expect(find.text(badgePill), findsOneWidget);
    expect(find.text(ctaEnterApp), findsOneWidget);
  });
}
