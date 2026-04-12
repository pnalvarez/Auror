import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/cards/disclaimer_card.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

/// Showcases [DisclaimerCard] on the dark onboarding theme (primary rail + chip).
class DisclaimerCardDemo extends StatelessWidget {
  const DisclaimerCardDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: Builder(
        builder: (context) {
          final scheme = Theme.of(context).colorScheme;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Rounded surface with an inset primary accent rail, numbered chip, '
                'title, and supporting text.',
                style: body2Medium.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacings.xl2),
              Text('Stacked (typical session)', style: headlineS),
              const SizedBox(height: AppSpacings.m),
              const DisclaimerCard(
                step: 1,
                title: '3 cards',
                description: 'Um por vez, sem scroll infinito.',
              ),
              const SizedBox(height: AppSpacings.xl2),
              const DisclaimerCard(
                step: 2,
                title: 'Mostrar resposta',
                description: 'Você tenta lembrar, depois revela.',
              ),
              const SizedBox(height: AppSpacings.xl2),
              const DisclaimerCard(
                step: 3,
                title: 'Score 0–2',
                description:
                    'Você marca de 0 a 2. O app agenda as próximas revisões.',
              ),
            ],
          );
        },
      ),
    );
  }
}
