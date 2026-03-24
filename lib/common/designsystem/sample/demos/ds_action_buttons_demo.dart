import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/designsystem/molecules/buttons/button_brand.dart';
import 'package:flutter/material.dart';

/// Demo list for [PrimaryButton], [SecondaryButton], and [TertiaryButton]:
/// Default sections list brands × enabled / disabled; the Loading section shows
/// each variant with `loading: true` (label hidden, spinner centered).
class ActionButtonsDemo extends StatelessWidget {
  const ActionButtonsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Filled, outlined, and text buttons across brand palettes.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        _Section(
          title: 'Primary',
          children: [
            PrimaryButton(
              label: 'Primary · primary · enabled',
              brand: ButtonBrand.primary,
              enabled: true,
              action: () {},
            ),
            PrimaryButton(
              label: 'Primary · primary · disabled',
              brand: ButtonBrand.primary,
              enabled: false,
              action: () {},
            ),
            PrimaryButton(
              label: 'Primary · secondary · enabled',
              brand: ButtonBrand.secondary,
              enabled: true,
              action: () {},
            ),
            PrimaryButton(
              label: 'Primary · secondary · disabled',
              brand: ButtonBrand.secondary,
              enabled: false,
              action: () {},
            ),
            PrimaryButton(
              label: 'Primary · tertiary · enabled',
              brand: ButtonBrand.tertiary,
              enabled: true,
              action: () {},
            ),
            PrimaryButton(
              label: 'Primary · tertiary · disabled',
              brand: ButtonBrand.tertiary,
              enabled: false,
              action: () {},
            ),
          ],
        ),
        _Section(
          title: 'Secondary',
          children: [
            SecondaryButton(
              label: 'Secondary · primary · enabled',
              brand: ButtonBrand.primary,
              enabled: true,
              action: () {},
            ),
            SecondaryButton(
              label: 'Secondary · primary · disabled',
              brand: ButtonBrand.primary,
              enabled: false,
              action: () {},
            ),
            SecondaryButton(
              label: 'Secondary · secondary · enabled',
              brand: ButtonBrand.secondary,
              enabled: true,
              action: () {},
            ),
            SecondaryButton(
              label: 'Secondary · secondary · disabled',
              brand: ButtonBrand.secondary,
              enabled: false,
              action: () {},
            ),
            SecondaryButton(
              label: 'Secondary · tertiary · enabled',
              brand: ButtonBrand.tertiary,
              enabled: true,
              action: () {},
            ),
            SecondaryButton(
              label: 'Secondary · tertiary · disabled',
              brand: ButtonBrand.tertiary,
              enabled: false,
              action: () {},
            ),
          ],
        ),
        _Section(
          title: 'Tertiary',
          children: [
            TertiaryButton(
              label: 'Tertiary · primary · enabled',
              brand: ButtonBrand.primary,
              enabled: true,
              action: () {},
            ),
            TertiaryButton(
              label: 'Tertiary · primary · disabled',
              brand: ButtonBrand.primary,
              enabled: false,
              action: () {},
            ),
            TertiaryButton(
              label: 'Tertiary · secondary · enabled',
              brand: ButtonBrand.secondary,
              enabled: true,
              action: () {},
            ),
            TertiaryButton(
              label: 'Tertiary · secondary · disabled',
              brand: ButtonBrand.secondary,
              enabled: false,
              action: () {},
            ),
            TertiaryButton(
              label: 'Tertiary · tertiary · enabled',
              brand: ButtonBrand.tertiary,
              enabled: true,
              action: () {},
            ),
            TertiaryButton(
              label: 'Tertiary · tertiary · disabled',
              brand: ButtonBrand.tertiary,
              enabled: false,
              action: () {},
            ),
          ],
        ),
        _Section(
          title: 'Loading',
          children: [
            PrimaryButton(
              label: 'Primary · primary · loading',
              brand: ButtonBrand.primary,
              enabled: true,
              loading: true,
              action: () {},
            ),
            PrimaryButton(
              label: 'Primary · secondary · loading',
              brand: ButtonBrand.secondary,
              enabled: true,
              loading: true,
              action: () {},
            ),
            PrimaryButton(
              label: 'Primary · tertiary · loading',
              brand: ButtonBrand.tertiary,
              enabled: true,
              loading: true,
              action: () {},
            ),
            SecondaryButton(
              label: 'Secondary · primary · loading',
              brand: ButtonBrand.primary,
              enabled: true,
              loading: true,
              action: () {},
            ),
            SecondaryButton(
              label: 'Secondary · secondary · loading',
              brand: ButtonBrand.secondary,
              enabled: true,
              loading: true,
              action: () {},
            ),
            SecondaryButton(
              label: 'Secondary · tertiary · loading',
              brand: ButtonBrand.tertiary,
              enabled: true,
              loading: true,
              action: () {},
            ),
            TertiaryButton(
              label: 'Tertiary · primary · loading',
              brand: ButtonBrand.primary,
              enabled: true,
              loading: true,
              action: () {},
            ),
            TertiaryButton(
              label: 'Tertiary · secondary · loading',
              brand: ButtonBrand.secondary,
              enabled: true,
              loading: true,
              action: () {},
            ),
            TertiaryButton(
              label: 'Tertiary · tertiary · loading',
              brand: ButtonBrand.tertiary,
              enabled: true,
              loading: true,
              action: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacings.xl2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacings.m,
        children: [
          Text(title, style: headlineS),
          ...children,
        ],
      ),
    );
  }
}
