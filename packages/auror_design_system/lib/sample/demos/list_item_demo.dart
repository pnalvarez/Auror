import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:auror_design_system/sample/demos/list_item_brands_demo.dart';
import 'package:flutter/material.dart';

/// Showcases [ListItem] with [IconTitleDescriptionInput], [IconTitleParagraphInput],
/// [TitleDescriptionCTAProgressInput], and [GenericListItemInput].
class ListItemDemo extends StatelessWidget {
  const ListItemDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Tappable card row: polymorphic [ListItemInput] builds the inner layout; '
          'the shell handles surface, border, and ink. Use [isEnabled]: false to '
          'dim inner content and disable tap.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Card com badges', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: BadgesTitleDescriptionInput(
            topMainBadgeText: 'Desenvolvimento Pessoal',
            topSecondBadgeText: 'Premium',
            title: 'Autoliderança',
            description:
                'Desenvolva a capacidade de gerenciar a si mesmo, suas emoções '
                'e seu tempo para alcançar metas pessoais e profissionais.',
            trailingIcon: Icons.lock_outline_rounded,
          ),
          padding: const EdgeInsets.all(AppSpacings.xl2),
          isExpanded: true,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Título, descrição, CTA e progresso', style: headlineS),
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
        const SizedBox(height: AppSpacings.xl2),
        Text('Plano / upgrade', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: IconTitleDescriptionInput(
            leadingIcon: Icons.workspace_premium_outlined,
            title: 'Plano Grátis',
            description: 'Fazer upgrade → R\$ 9,90/mês',
          ),
          isExpanded: true,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Descrição com ícone à esquerda', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: IconTitleDescriptionInput(
            leadingIcon: Icons.person_outline_rounded,
            title: 'Perfil',
            description: 'Informações visíveis para outros leitores',
            descriptionLeadingIcon: Icons.visibility_outlined,
          ),
          isExpanded: true,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Sem chevron', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: IconTitleDescriptionInput(
            leadingIcon: Icons.notifications_outlined,
            title: 'Lembretes',
            description: 'Gerenciar notificações de estudo',
            showTrailing: false,
          ),
          isExpanded: true,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Título + parágrafo (vertical)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: IconTitleParagraphInput(
            leadingIcon: Icons.format_quote_rounded,
            title: 'Resposta esperada',
            description:
                'Bloco informativo com ícone opcional; estados adicionais em '
                'demoId list_item_icon_title_paragraph.',
          ),
          brand: ListItemBrand.neutral,
          isExpanded: true,
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Genérico', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: GenericListItemInput(
            child: Row(
              children: [
                Icon(
                  Icons.extension_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: AppSpacings.m),
                Expanded(
                  child: Text(
                    'Conteúdo customizado com GenericListItemInput',
                    style: body2Medium.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          isExpanded: true,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Desativado', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        Text(
          '[isEnabled]: false — conteúdo interno com opacidade reduzida; toque '
          'desligado.',
          style: body3Light.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: IconTitleDescriptionInput(
            leadingIcon: Icons.workspace_premium_outlined,
            title: 'Ítem indisponível',
            description: 'Mesmo padrão que “Plano / upgrade”, sem interação.',
          ),
          isExpanded: true,
          isEnabled: false,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        const Divider(height: 1),
        const SizedBox(height: AppSpacings.xl2),
        const ListItemBrandsDemo(),
        const SizedBox(height: AppSpacings.xl2),
        ListItem(
          input: TextInput(text: 'Some text - Neutral'),
          isEnabled: false,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        ListItem(
          input: TextInput(text: 'Some text - Success'),
          brand: ListItemBrand.success,
          isEnabled: false,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        ListItem(
          input: TextInput(text: 'Some text - Warning'),
          brand: ListItemBrand.warning,
          isEnabled: false,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        ListItem(
          input: TextInput(text: 'Some text - Error'),
          brand: ListItemBrand.error,
          isEnabled: false,
          onTap: () {},
        ),
      ],
    );
  }
}
