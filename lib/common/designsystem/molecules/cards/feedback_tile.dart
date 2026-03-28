import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Semantic state for [FeedbackTile]: fixed icon and accent per variant.
enum FeedbackTileState {
  error,
  warning,
  success,
}

/// Tappable rounded card for spaced-repetition-style feedback: icon, title, subtitle.
///
/// [state] selects the icon and border/text color; [title], [subtitle], and [onTap] are
/// provided by the caller. Optional [width] and [height] (use both) pin the tile size and
/// center the content.
class FeedbackTile extends StatelessWidget {
  const FeedbackTile({
    super.key,
    required this.state,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.width,
    this.height,
  });

  final FeedbackTileState state;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  /// When both are set, the tile is exactly this size (e.g. horizontal toolbars).
  final double? width;
  final double? height;

  static const double _iconSize = 22;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = _FeedbackTileStyle.of(state);

    final titleStyle = body3Semibold.copyWith(
      color: style.accent,
      fontWeight: FontWeight.w700,
      height: 1.2,
    );
    final subtitleStyle = tagS.copyWith(
      color: style.accent,
      height: 1.15,
    );

    final padded = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.s,
        vertical: AppSpacings.m,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(style.icon, size: _iconSize, color: style.accent),
          const SizedBox(height: AppSpacings.xs),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: titleStyle,
          ),
          const SizedBox(height: AppSpacings.xs),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: subtitleStyle,
          ),
        ],
      ),
    );

    final ink = Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xl2),
        child: width != null && height != null ? Center(child: padded) : padded,
      ),
    );

    final content = DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.xl2),
        border: Border.all(color: style.accent, width: 2),
      ),
      child: ink,
    );

    if (width != null && height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: content,
      );
    }
    return content;
  }
}

@immutable
class _FeedbackTileStyle {
  const _FeedbackTileStyle({
    required this.accent,
    required this.icon,
  });

  final Color accent;
  final IconData icon;

  /// Accents tuned for dark surfaces (border, icon, title, subtitle).
  static _FeedbackTileStyle of(FeedbackTileState state) {
    return switch (state) {
      FeedbackTileState.error => const _FeedbackTileStyle(
          accent: Color(0xFFFF6B6B),
          icon: Icons.replay_rounded,
        ),
      FeedbackTileState.warning => const _FeedbackTileStyle(
          accent: Color(0xFFFFD93D),
          icon: Icons.horizontal_rule_rounded,
        ),
      FeedbackTileState.success => const _FeedbackTileStyle(
          accent: Color(0xFF2ECC71),
          icon: Icons.thumb_up_outlined,
        ),
    };
  }
}
