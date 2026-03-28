import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/cards/recall_card.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

/// Showcases [RecallCard]: topic pill, copy, reveal, expected answer, fixed feedback row.
class RecallCardDemo extends StatelessWidget {
  const RecallCardDemo({super.key});

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
                'Tap "Ver resposta" to show the expected answer and the three feedback tiles.',
                style: body2Medium.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacings.xl2),
              RecallCard(
                topic: 'Card',
                title: 'O que é "active recall"?',
                description:
                    'Tente responder mentalmente antes de ver a resposta.',
                expectedAnswer:
                    'Active recall é a prática de tentar lembrar de um fato ou '
                    'conceito a partir da memória, em vez de reler passivamente. '
                    'Isso fortaleça as conexões neurais e melhora a retenção.',
                onFeedback: (kind) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Feedback: $kind')),
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
