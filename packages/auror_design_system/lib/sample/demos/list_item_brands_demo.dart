import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:flutter/material.dart';

/// One [ListItem] for catalog screens that focus on a single [ListItemBrand].
class ListItemBrandSingleDemo extends StatelessWidget {
  const ListItemBrandSingleDemo({super.key, required this.brand});

  final ListItemBrand brand;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final data = switch (brand) {
      ListItemBrand.neutral => (
        Icons.article_outlined,
        'Marca neutra',
        'Superfície e tipografia padrão do tema.',
      ),
      ListItemBrand.success => (
        Icons.check_circle_outline_rounded,
        'Marca sucesso',
        'Verde semântico para confirmação.',
      ),
      ListItemBrand.warning => (
        Icons.warning_amber_rounded,
        'Marca aviso',
        'Âmbar para chamar atenção sem erro.',
      ),
      ListItemBrand.error => (
        Icons.error_outline_rounded,
        'Marca erro',
        'Vermelho para falha ou bloqueio.',
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Um único card com [ListItemBrand.${brand.name}].',
          style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacings.xl2),
        ListItem(
          brand: brand,
          input: IconTitleDescriptionInput(
            leadingIcon: data.$1,
            title: data.$2,
            description: data.$3,
          ),
          isExpanded: true,
          onTap: () {},
        ),
      ],
    );
  }
}

/// Gallery: neutral, success, warning, error in one scroll.
class ListItemBrandsDemo extends StatelessWidget {
  const ListItemBrandsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '[ListItemBrand] sets shell fill, border, and default title/body/icon '
          'colors. [ListItemBrand.neutral] matches the original neutral card.',
          style: body2Medium.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Neutral', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          brand: ListItemBrand.neutral,
          input: IconTitleDescriptionInput(
            leadingIcon: Icons.article_outlined,
            title: 'Conteúdo padrão',
            description: 'Borda neutra e ícone dourado (DarkContent).',
          ),
          isExpanded: true,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Success', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          brand: ListItemBrand.success,
          input: IconTitleDescriptionInput(
            leadingIcon: Icons.check_circle_outline_rounded,
            title: 'Meta concluída',
            description: 'Texto e ícones em tons de verde de sucesso.',
          ),
          isExpanded: true,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Warning', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          brand: ListItemBrand.warning,
          input: IconTitleDescriptionInput(
            leadingIcon: Icons.warning_amber_rounded,
            title: 'Atenção necessária',
            description: 'Destaque âmbar para revisar antes de continuar.',
          ),
          isExpanded: true,
          onTap: () {},
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Error', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          brand: ListItemBrand.error,
          input: IconTitleDescriptionInput(
            leadingIcon: Icons.error_outline_rounded,
            title: 'Algo falhou',
            description: 'Vermelho semântico para estados de erro.',
          ),
          isExpanded: true,
          onTap: () {},
        ),
      ],
    );
  }
}

/// Catalog entry: [ListItemBrand.neutral] only.
class ListItemBrandNeutralCatalogDemo extends StatelessWidget {
  const ListItemBrandNeutralCatalogDemo({super.key});

  @override
  Widget build(BuildContext context) =>
      const ListItemBrandSingleDemo(brand: ListItemBrand.neutral);
}

/// Catalog entry: [ListItemBrand.success] only.
class ListItemBrandSuccessCatalogDemo extends StatelessWidget {
  const ListItemBrandSuccessCatalogDemo({super.key});

  @override
  Widget build(BuildContext context) =>
      const ListItemBrandSingleDemo(brand: ListItemBrand.success);
}

/// Catalog entry: [ListItemBrand.warning] only.
class ListItemBrandWarningCatalogDemo extends StatelessWidget {
  const ListItemBrandWarningCatalogDemo({super.key});

  @override
  Widget build(BuildContext context) =>
      const ListItemBrandSingleDemo(brand: ListItemBrand.warning);
}

/// Catalog entry: [ListItemBrand.error] only.
class ListItemBrandErrorCatalogDemo extends StatelessWidget {
  const ListItemBrandErrorCatalogDemo({super.key});

  @override
  Widget build(BuildContext context) =>
      const ListItemBrandSingleDemo(brand: ListItemBrand.error);
}
