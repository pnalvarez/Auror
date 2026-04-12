import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/tooltip/ds_tooltip.dart';
import 'package:flutter/material.dart';

/// Showcases [DsTooltip] brands and [DsTooltipPlacement] variants.
class TooltipDemo extends StatelessWidget {
  const TooltipDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final muted = body2Medium.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );

    Widget anchor(String label, {double width = 200}) {
      return SizedBox(
        width: width,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacings.m,
            vertical: AppSpacings.s,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(
                alpha: 0.4,
              ),
            ),
            borderRadius: BorderRadius.circular(AppSpacings.s),
          ),
          child: Text(label, style: body3Medium),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Tail aligns to start, center, or end of the anchor; balloon above (*Top) or below (*Bottom).',
          style: muted,
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Brands (center · below)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        Center(
          child: DsTooltip(
            text: 'Neutral (primary)',
            brand: DsTooltipBrand.neutral,
            placement: DsTooltipPlacement.centerBottom,
            child: anchor('Button'),
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Center(
          child: DsTooltip(
            text: 'Saved',
            brand: DsTooltipBrand.success,
            placement: DsTooltipPlacement.centerBottom,
            child: anchor('Success'),
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Center(
          child: DsTooltip(
            text: 'Check dates',
            brand: DsTooltipBrand.warning,
            placement: DsTooltipPlacement.centerBottom,
            child: anchor('Warning'),
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Center(
          child: DsTooltip(
            text: 'Could not load',
            brand: DsTooltipBrand.error,
            placement: DsTooltipPlacement.centerBottom,
            child: anchor('Error'),
          ),
        ),
        const SizedBox(height: AppSpacings.xl3),
        Text('Placement (balloon above)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        Center(
          child: DsTooltip(
            text: 'startTop',
            placement: DsTooltipPlacement.startTop,
            child: anchor('Wide row', width: 260),
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Center(
          child: DsTooltip(
            text: 'centerTop',
            placement: DsTooltipPlacement.centerTop,
            child: anchor('Wide row', width: 260),
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Center(
          child: DsTooltip(
            text: 'endTop',
            placement: DsTooltipPlacement.endTop,
            child: anchor('Wide row', width: 260),
          ),
        ),
        const SizedBox(height: AppSpacings.xl3),
        Text('Placement (balloon below)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        Center(
          child: DsTooltip(
            text: 'startBottom',
            placement: DsTooltipPlacement.startBottom,
            child: anchor('Wide row', width: 260),
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Center(
          child: DsTooltip(
            text: 'centerBottom',
            placement: DsTooltipPlacement.centerBottom,
            child: anchor('Wide row', width: 260),
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Center(
          child: DsTooltip(
            text: 'endBottom',
            placement: DsTooltipPlacement.endBottom,
            child: anchor('Wide row', width: 260),
          ),
        ),
      ],
    );
  }
}
