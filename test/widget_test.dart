import 'package:flutter_test/flutter_test.dart';

import 'package:auror/main.dart';

void main() {
  testWidgets('App boots on design system menu', (WidgetTester tester) async {
    await tester.pumpWidget(const AurorApp());
    await tester.pumpAndSettle();

    expect(find.text('Design system'), findsOneWidget);
    expect(find.text('Action buttons'), findsOneWidget);
  });
}
