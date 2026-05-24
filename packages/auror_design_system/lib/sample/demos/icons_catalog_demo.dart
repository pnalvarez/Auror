import 'package:auror_design_system/atoms/icons/app_icons.dart';
import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Lists bundled SVG icons from [AppIcons] at 24 and 48 logical pixels.
class IconsCatalogDemo extends StatelessWidget {
  const IconsCatalogDemo({super.key});

  static const _previewSizes = [24.0, 48.0];

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final outline = Theme.of(context).colorScheme.outlineVariant;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppIcons.catalog.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacings.m),
      itemBuilder: (context, index) {
        final entry = AppIcons.catalog[index];
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.m),
            border: Border.all(color: outline),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacings.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SelectableText(
                  entry.name,
                  style: body2Medium.copyWith(color: onSurface, height: 1.35),
                ),
                const SizedBox(height: AppSpacings.s),
                SelectableText(
                  entry.asset,
                  style: labelM.copyWith(color: onSurface),
                ),
                const SizedBox(height: AppSpacings.l),
                Wrap(
                  spacing: AppSpacings.xl,
                  runSpacing: AppSpacings.m,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    for (final size in _previewSizes)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            entry.asset,
                            package: AppIcons.package,
                            width: size,
                            height: size,
                          ),
                          const SizedBox(height: AppSpacings.s),
                          Text(
                            '${size.toInt()}px',
                            style: labelM.copyWith(color: onSurface),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
