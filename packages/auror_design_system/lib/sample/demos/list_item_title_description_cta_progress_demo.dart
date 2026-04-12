import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:flutter/material.dart';

/// [ListItem] with [TitleDescriptionCTAProgressInput]: title, subtitle line,
/// primary CTA, and step progress.
class ListItemTitleDescriptionCtaProgressDemo extends StatelessWidget {
  const ListItemTitleDescriptionCtaProgressDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Linha superior com título e descrição à esquerda, botão primário à '
          'direita; divisor; barra de progresso com legenda current/total.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Sem progresso (0 / total)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: TitleDescriptionCTAProgressInput(
            title: 'Descubra algo novo',
            description: '3 ideias selecionadas para você · ~7 min',
            ctaText: 'Aprender agora',
            onCtaTap: () {},
            currentProgress: 0,
            totalProgress: 3,
          ),
          padding: const EdgeInsets.all(AppSpacings.xl2),
          isExpanded: true,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Em andamento', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: TitleDescriptionCTAProgressInput(
            title: 'Descubra algo novo',
            description: '3 ideias selecionadas para você · ~7 min',
            ctaText: 'Aprender agora',
            onCtaTap: () {},
            currentProgress: 2,
            totalProgress: 3,
          ),
          padding: const EdgeInsets.all(AppSpacings.xl2),
          isExpanded: true,
          onTap: () {},
        ),
      ],
    );
  }
}
