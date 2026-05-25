import 'package:auror_design_system/organisms/feedback/shimmer_rectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  testWidgets('ShimmerRectangle builds with explicit size', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: ShimmerRectangle(width: 120, height: 24),
          ),
        ),
      ),
    );

    expect(find.byType(ShimmerRectangle), findsOneWidget);
    expect(find.byType(Shimmer), findsOneWidget);

    final box = tester.getSize(find.byType(ShimmerRectangle));
    expect(box.width, 120);
    expect(box.height, 24);
  });

  testWidgets('ShimmerRectangle expands when width is null', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 200,
            child: ShimmerRectangle(height: 10),
          ),
        ),
      ),
    );

    final box = tester.getSize(find.byType(ShimmerRectangle));
    expect(box.width, 200);
    expect(box.height, 10);
  });
}
