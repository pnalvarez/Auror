import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/list_item/list_item.dart';
import 'package:flutter/material.dart';

/// [ListItem] with [TitleDescriptionCheckpointsInput]: title, description,
/// optional trailing line, bullet checkpoints, optional CTA, optional footer.
class ListItemTitleDescriptionCheckpointsDemo extends StatelessWidget {
  const ListItemTitleDescriptionCheckpointsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Cabeçalho com título e descrição à esquerda e texto opcional à '
          'direita; lista de checkpoints; CTA e rodapé opcionais.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Com trailing, checkpoints e CTA', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: TitleDescriptionCheckpointsInput(
            style: TitleDescriptionCheckpointsInputStyle.standard,
            title: 'Objetivo da semana',
            description: 'Leitura guiada · ~20 min',
            firstTrailingItem: r'R$9,99',
            secondTrailingItem: 'mês',
            checkpoints: const [
              'Capítulo 3 — notas no fim do dia',
              'Revisão espaçada (cartões)',
            ],
            primaryCtaText: 'Continuar',
            onTapPrimaryCTA: () {},
          ),
          padding: const EdgeInsets.all(AppSpacings.xl2),
          isExpanded: true,
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Checkpoints e rodapé (sem CTA)', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: TitleDescriptionCheckpointsInput(
            style: TitleDescriptionCheckpointsInputStyle.tertiary,
            title: 'Check-in rápido',
            description: 'Antes de fechar a sessão',
            firstTrailingItem: r'R$9,99',
            secondTrailingItem: 'mês',
            checkpoints: const [
              'O que ficou mais claro?',
              'O que você aplicaria amanhã?',
            ],
            primaryCtaText: 'Assinar agora',
            footerText:
                'Respostas são só para você — não enviamos para a nuvem.',
            onTapPrimaryCTA: () {},
          ),
          padding: const EdgeInsets.all(AppSpacings.xl2),
          isExpanded: true,
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Quaternário', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: TitleDescriptionCheckpointsInput(
            style: TitleDescriptionCheckpointsInputStyle.quaternary,
            title: 'Check-in rápido',
            description: 'Antes de fechar a sessão',
            firstTrailingItem: r'R$99,99',
            secondTrailingItem: 'ano',
            checkpoints: const [
              'O que ficou mais claro?',
              'O que você aplicaria amanhã?',
            ],
            primaryCtaText: 'Assinar agora',
            footerText:
                'Respostas são só para você — não enviamos para a nuvem.',
            onTapPrimaryCTA: () {},
          ),
          padding: const EdgeInsets.all(AppSpacings.xl2),
          isExpanded: true,
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Com botão terciário', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        ListItem(
          input: TitleDescriptionCheckpointsInput(
            style: TitleDescriptionCheckpointsInputStyle.tertiary,
            title: 'Plano Pro',
            description: 'Aproveite todos os recursos premium',
            firstTrailingItem: r'19,99',
            secondTrailingItem: 'mês',
            checkpoints: const [
              'Acesso ilimitado aos conteúdos',
              'Trilhas e desafios exclusivos',
            ],
            tertiaryCTAText: 'Ver detalhes',
            onTapTertiaryCTA: () {},
          ),
          padding: const EdgeInsets.all(AppSpacings.xl2),
          isExpanded: true,
        ),
      ],
    );
  }
}
