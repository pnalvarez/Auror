import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

void showCustomDialog(
  BuildContext context,
  String title,
  Widget content,
  List<Widget> actions,
) {
  final scheme = Theme.of(context).colorScheme;
  showDialog<void>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.l),
          side: BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
        ),
        title: Text(title, style: headlineS.copyWith(color: scheme.onSurface)),
        content: content,
      );
    },
  );
}
