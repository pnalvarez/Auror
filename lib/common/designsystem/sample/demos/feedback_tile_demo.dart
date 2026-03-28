import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/cards/feedback_tile.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:flutter/material.dart';

/// Showcases [FeedbackTile] for error, warning, and success (dark session UI).
class FeedbackTileDemo extends StatelessWidget {
  const FeedbackTileDemo({super.key});

  static const double _tileWidth = 108;
  static const double _tileHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainLaunchDarkTheme(),
      child: Builder(
        builder: (context) {
          final scheme = Theme.of(context).colorScheme;
          void showTap(String id) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tapped: $id')),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tappable feedback cards: state sets icon and accent; title, subtitle, '
                'and tap handler are passed in.',
                style: body2Medium.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacings.xl2),
              Text('Row (fixed size)', style: headlineS),
              const SizedBox(height: AppSpacings.m),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FeedbackTile(
                      state: FeedbackTileState.error,
                      title: 'Não lembrei',
                      subtitle: 'D+1',
                      width: _tileWidth,
                      height: _tileHeight,
                      onTap: () => showTap('error'),
                    ),
                    const SizedBox(width: AppSpacings.s),
                    FeedbackTile(
                      state: FeedbackTileState.warning,
                      title: 'Parcial',
                      subtitle: 'D+3',
                      width: _tileWidth,
                      height: _tileHeight,
                      onTap: () => showTap('warning'),
                    ),
                    const SizedBox(width: AppSpacings.s),
                    FeedbackTile(
                      state: FeedbackTileState.success,
                      title: 'Lembrei!',
                      subtitle: 'D+7',
                      width: _tileWidth,
                      height: _tileHeight,
                      onTap: () => showTap('success'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
