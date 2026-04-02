import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/organisms/list_item/list_item.dart';
import 'package:flutter/material.dart';

/// Showcases [ListItem] with [IconTitleDescriptionInput] and [GenericListItemInput].
class ListItemDemo extends StatelessWidget {
  const ListItemDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Tappable card row: polymorphic [ListItemInput] builds the inner layout; '
          'the shell handles surface, border, and ink.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
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
      ],
    );
  }
}
