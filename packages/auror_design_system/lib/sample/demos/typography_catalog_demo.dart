import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Lists every exported [TextStyle] from [typography.dart]; each row uses that
/// style for its label (the public variable name).
class TypographyCatalogDemo extends StatelessWidget {
  const TypographyCatalogDemo({super.key});

  static List<({String name, TextStyle style})> _entries() => [
        (name: 'headlineXl', style: headlineXl),
        (name: 'headlineL', style: headlineL),
        (name: 'headlineM', style: headlineM),
        (name: 'headlineS', style: headlineS),
        (name: 'headlineXs', style: headlineXs),
        (name: 'headline2xs', style: headline2xs),
        (name: 'subtitleXl', style: subtitleXl),
        (name: 'subtitleL', style: subtitleL),
        (name: 'subtitleM', style: subtitleM),
        (name: 'subtitleS', style: subtitleS),
        (name: 'subtitleXs', style: subtitleXs),
        (name: 'subtitle2xs', style: subtitle2xs),
        (name: 'headingH1', style: headingH1),
        (name: 'headingH2', style: headingH2),
        (name: 'headingH3', style: headingH3),
        (name: 'headingH4', style: headingH4),
        (name: 'headingH5', style: headingH5),
        (name: 'headingH6', style: headingH6),
        (name: 'subtitle1', style: subtitle1),
        (name: 'subtitle2', style: subtitle2),
        (name: 'subtitle3', style: subtitle3),
        (name: 'subtitle4', style: subtitle4),
        (name: 'subtitle5', style: subtitle5),
        (name: 'subtitle6', style: subtitle6),
        (name: 'body1Light', style: body1Light),
        (name: 'body2Light', style: body2Light),
        (name: 'body3Light', style: body3Light),
        (name: 'body3Placeholder', style: body3Placeholder),
        (name: 'body4Light', style: body4Light),
        (name: 'body5Light', style: body5Light),
        (name: 'body6Light', style: body6Light),
        (name: 'body1Medium', style: body1Medium),
        (name: 'body2Medium', style: body2Medium),
        (name: 'body3Medium', style: body3Medium),
        (name: 'body4Medium', style: body4Medium),
        (name: 'body5Medium', style: body5Medium),
        (name: 'body1Semibold', style: body1Semibold),
        (name: 'body2Semibold', style: body2Semibold),
        (name: 'body3Semibold', style: body3Semibold),
        (name: 'body4Semibold', style: body4Semibold),
        (name: 'body5Semibold', style: body5Semibold),
        (name: 'body6Semibold', style: body6Semibold),
        (name: 'labelL', style: labelL),
        (name: 'labelM', style: labelM),
        (name: 'labelS', style: labelS),
        (name: 'tagRegular', style: tagRegular),
        (name: 'tagS', style: tagS),
        (name: 'tagXS', style: tagXS),
      ];

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final entries = _entries();
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacings.xl),
      itemBuilder: (context, index) {
        final e = entries[index];
        return Align(
          alignment: Alignment.centerLeft,
          child: Text(
            e.name,
            style: e.style.copyWith(color: onSurface),
          ),
        );
      },
    );
  }
}
