import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:flutter/material.dart';

/// [ListItem] with [IconTitleParagraphInput]: optional leading icon, title,
/// paragraph body.
class ListItemIconTitleParagraphDemo extends StatelessWidget {
  const ListItemIconTitleParagraphDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Card vertical: ícone opcional antes do título, parágrafo abaixo; '
          'sem chevron.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Com ícone', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: IconTitleParagraphInput(
            leadingIcon: Icons.check_circle_outline_rounded,
            title: 'Resposta esperada',
            description:
                'Permite regular emoções, empatizar com a equipe e decidir sob '
                'pressão sem sabotar relacionamentos nem resultados.',
          ),
          brand: ListItemBrand.warning,
          isExpanded: true,
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Sem ícone', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: IconTitleParagraphInput(
            title: 'Resposta esperada',
            description:
                'Texto de apoio em parágrafo quando não há ícone à esquerda.',
          ),
          brand: ListItemBrand.warning,
          isExpanded: true,
        ),
      ],
    );
  }
}
