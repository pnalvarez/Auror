import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/cards/score_tile.dart';
import 'package:flutter/material.dart';

/// Showcases [ScoreTile] with typical icons and copy.
class ScoreTileDemo extends StatelessWidget {
  const ScoreTileDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Compact stat tile: icon, score, and label. Fits rows or grids.',
          style: body2Medium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Single', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        const Center(
          child: ScoreTile(
            icon: Icons.menu_book_outlined,
            score: 0,
            label: 'Cards aprendidos',
          ),
        ),
        const SizedBox(height: AppSpacings.xl2),
        Text('Row', style: headlineS),
        const SizedBox(height: AppSpacings.m),
        Row(
          children: [
            Expanded(
              child: ScoreTile(
                icon: Icons.menu_book_outlined,
                score: 12,
                label: 'Cards aprendidos',
              ),
            ),
            const SizedBox(width: AppSpacings.m),
            Expanded(
              child: ScoreTile(
                icon: Icons.style_outlined,
                score: 3,
                label: 'Decks ativos',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacings.m),
        Row(
          children: [
            Expanded(
              child: ScoreTile(
                icon: Icons.local_fire_department_outlined,
                score: 7,
                label: 'Dias seguidos',
              ),
            ),
            const SizedBox(width: AppSpacings.m),
            Expanded(
              child: ScoreTile(
                icon: Icons.quiz_outlined,
                score: 128,
                label: 'Revisões',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
