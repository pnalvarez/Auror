import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Content block with optional leading label, media slot, title, and body.
///
/// [icon] is commonly an [Icon] or [Image]; tint with [AppColors.DarkContent.accent]
/// when using the default dark palette.
class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.topText,
    required this.icon,
    required this.title,
    required this.description,
  });

  final String topText;
  final Widget icon;
  final String title;
  final String description;

  static const double _iconWellSize = 52;

  @override
  Widget build(BuildContext context) {
    final c = AppColors.DarkContent;
    final titleStyle = headlineS.copyWith(color: Colors.white);
    final bodyStyle = body2Light.copyWith(
      color: AppColors.Text.Inverse.secondary,
      height: 1.45,
    );
    final topStyle = headlineM.copyWith(
      color: c.accent,
      height: 1.1,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadius.l),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacings.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              topText,
              style: topStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacings.l),
            DecoratedBox(
              decoration: BoxDecoration(
                color: c.iconWell,
                borderRadius: BorderRadius.circular(AppRadius.s),
              ),
              child: SizedBox(
                width: _iconWellSize,
                height: _iconWellSize,
                child: Center(child: icon),
              ),
            ),
            const SizedBox(height: AppSpacings.l),
            Text(
              title,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacings.s),
            Text(
              description,
              style: bodyStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
