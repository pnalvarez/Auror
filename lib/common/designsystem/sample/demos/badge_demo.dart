import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/badges/badge.dart';
import 'package:flutter/material.dart' hide Badge;

/// Showcases [Badge] neutral and premium (icon + label) variants.
class BadgeDemo extends StatelessWidget {
  const BadgeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Compact pill for categories and accent labels; optional leading icon.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Neutral', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const Align(
          alignment: Alignment.centerLeft,
          child: Badge(
            label: 'Desenvolvimento Pessoal',
            variant: BadgeVariant.neutral,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Premium (ícone + texto)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const Align(
          alignment: Alignment.centerLeft,
          child: Badge(
            label: 'Premium',
            leadingIcon: Icons.workspace_premium_outlined,
            variant: BadgeVariant.highlight,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Em linha', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const Wrap(
          spacing: AppSpacings.s,
          runSpacing: AppSpacings.s,
          children: [
            Badge(
              label: 'Desenvolvimento Pessoal',
              variant: BadgeVariant.neutral,
            ),
            Badge(
              label: 'Premium',
              leadingIcon: Icons.workspace_premium_outlined,
              variant: BadgeVariant.highlight,
            ),
          ],
        ),
      ],
    );
  }
}
