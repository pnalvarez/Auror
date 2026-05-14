import 'package:auror_design_system/molecules/chips/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('StatusChip renders label', (tester) async {
    const label = 'Test chip label';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: StatusChip(
              label: label,
              state: StatusChipState.neutral,
            ),
          ),
        ),
      ),
    );

    expect(find.text(label), findsOneWidget);
  });

  testWidgets('StatusChip hides dot when hasDot is false', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        home: const Scaffold(
          body: Center(
            child: StatusChip(
              label: 'No dot',
              state: StatusChipState.primary,
              hasDot: false,
            ),
          ),
        ),
      ),
    );

    expect(find.text('No dot'), findsOneWidget);
  });
}
