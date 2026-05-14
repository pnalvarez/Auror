import 'package:auror/common/strings/main_launch_strings.dart';
import 'package:auror/app_bootstrap.dart';
import 'package:auror/core/di/di.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await configureDependencies();
  });

  tearDownAll(() async {
    await getIt.reset();
  });

  testWidgets('App boots on main launch', (WidgetTester tester) async {
    await tester.pumpWidget(const AurorApp());
    await tester.pumpAndSettle();

    expect(find.text(badgePill), findsOneWidget);
    expect(find.text(ctaEnterApp), findsOneWidget);
  });
}
