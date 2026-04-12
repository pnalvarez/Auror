import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/organisms/media_backdrop_card/media_backdrop_card.dart';
import 'package:auror_design_system/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

/// Showcases [MediaBackdropCard]: full-bleed image, gradient, title, italic
/// quote, optional meta row, optional expand affordance.
class MediaBackdropCardDemo extends StatelessWidget {
  const MediaBackdropCardDemo({super.key});

  /// Landscape photo (HTTPS) suitable for hero cards.
  static const String _sampleImageUrl =
      'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1200&q=80';

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
                'A network image fills the card with [BoxFit.cover]; text sits '
                'on a bottom scrim. Optional labels mirror metadata slots '
                'without fixing a single use case.',
                style: body2Medium.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacings.xl2),
              MediaBackdropCard(
                title: 'O Poder dos Pequenos Hábitos.',
                quote:
                    '"Você não se eleva ao nível de seus objetivos. Você cai ao '
                    'nível de seus sistemas."',
                imageUrl: _sampleImageUrl,
                leadingLabel: 'Desenvolvimento Pessoal',
                trailingMeta: 'Dia 4',
                onExpand: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Expand tapped')),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
