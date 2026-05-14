import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/organisms/feedback/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CircularLoader builds at given size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularLoader(
              color: AppColors.Primary.primary,
              size: 48,
              strokeWidth: 4,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(CircularLoader), findsOneWidget);
  });
}
