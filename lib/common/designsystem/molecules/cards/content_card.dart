import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Content block with optional leading label, media slot, title, and body.
///
/// [icon] is commonly an [Icon] or [Image]; tint with [AppColors.DarkContent.accent]
/// when using the default dark palette.
///
/// Use [ContentCard.listTile] for a horizontal row (title + subtitle + leading icon)
/// aligned with [ThemeData.colorScheme] (e.g. Auror’s dark launch theme).
class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.topText,
    required this.icon,
    required this.title,
    required this.description,
  }) : _variant = _ContentCardVariant.hero,
       _listIcon = null,
       _listTitle = null,
       _listDescription = null,
       _listBody = null,
       _onListTap = null;

  /// Horizontal list row: icon well + title + description (mobile lists).
  const ContentCard.listTile({
    super.key,
    required Widget tileIcon,
    required String itemTitle,
    required String itemDescription,
    VoidCallback? onTap,
  }) : topText = '',
       icon = const SizedBox.shrink(),
       title = '',
       description = '',
       _variant = _ContentCardVariant.listTile,
       _listIcon = tileIcon,
       _listTitle = itemTitle,
       _listDescription = itemDescription,
       _listBody = null,
       _onListTap = onTap;

  /// Same as [ContentCard.listTile] but the text column is fully custom (e.g. [Text.rich]).
  const ContentCard.listTileCustom({
    super.key,
    required Widget tileIcon,
    required Widget body,
    VoidCallback? onTap,
  }) : topText = '',
       icon = const SizedBox.shrink(),
       title = '',
       description = '',
       _variant = _ContentCardVariant.listTileCustom,
       _listIcon = tileIcon,
       _listTitle = null,
       _listDescription = null,
       _listBody = body,
       _onListTap = onTap;

  final String topText;
  final Widget icon;
  final String title;
  final String description;

  final _ContentCardVariant _variant;
  final Widget? _listIcon;
  final String? _listTitle;
  final String? _listDescription;
  final Widget? _listBody;
  final VoidCallback? _onListTap;

  static const double _iconWellSize = 52;
  /// Compact list rows (guided routes, dense lists).
  static const double _listIconWellSize = 44;
  static const double _listIconSize = 22;

  @override
  Widget build(BuildContext context) {
    return switch (_variant) {
      _ContentCardVariant.hero => _buildHero(context),
      _ContentCardVariant.listTile => _buildListTile(context),
      _ContentCardVariant.listTileCustom => _buildListTileCustom(context),
    };
  }

  Widget _buildHero(BuildContext context) {
    final c = AppColors.DarkContent;
    final titleStyle = headlineXs.copyWith(color: Colors.white);
    final bodyStyle = body4Light.copyWith(
      color: AppColors.Text.Inverse.secondary,
      height: 1.45,
    );
    final topStyle = headlineM.copyWith(color: c.accent, height: 1.1);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadius.l),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacings.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(topText, style: topStyle, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacings.l),
            DecoratedBox(
              decoration: BoxDecoration(
                color: c.iconWell,
                borderRadius: BorderRadius.circular(AppRadius.s),
              ),
              child: SizedBox(
                width: _iconWellSize,
                height: _iconWellSize,
                child: Center(child: icon),
              ),
            ),
            const SizedBox(height: AppSpacings.l),
            Text(title, style: titleStyle, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacings.s),
            Text(description, style: bodyStyle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final titleStyle = labelS.copyWith(
      color: scheme.onSurface,
      height: 1.25,
    );
    final bodyStyle = body4Light.copyWith(
      color: scheme.onSurfaceVariant,
      height: 1.35,
    );
    final outline = scheme.outline.withValues(alpha: 0.35);

    final inner = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.m,
        vertical: AppSpacings.s,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ListIconWell(icon: _listIcon!),
          const SizedBox(width: AppSpacings.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_listTitle!, style: titleStyle),
                const SizedBox(height: AppSpacings.xs2),
                Text(_listDescription!, style: bodyStyle),
              ],
            ),
          ),
        ],
      ),
    );

    return _ListTileShell(outline: outline, onTap: _onListTap, child: inner);
  }

  Widget _buildListTileCustom(BuildContext context) {
    final outline = Theme.of(
      context,
    ).colorScheme.outline.withValues(alpha: 0.35);

    final inner = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.m,
        vertical: AppSpacings.s,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ListIconWell(icon: _listIcon!),
          const SizedBox(width: AppSpacings.m),
          Expanded(child: _listBody!),
        ],
      ),
    );

    return _ListTileShell(outline: outline, onTap: _onListTap, child: inner);
  }
}

enum _ContentCardVariant { hero, listTile, listTileCustom }

class _ListIconWell extends StatelessWidget {
  const _ListIconWell({required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.s),
        border: Border.all(
          color: AppColors.Primary.primary.withValues(alpha: 0.45),
          width: 1,
        ),
      ),
      child: SizedBox(
        width: ContentCard._listIconWellSize,
        height: ContentCard._listIconWellSize,
        child: Center(
          child: IconTheme.merge(
            data: IconThemeData(
              color: AppColors.Inverse.inversePrimary,
              size: ContentCard._listIconSize,
            ),
            child: icon,
          ),
        ),
      ),
    );
  }
}

class _ListTileShell extends StatelessWidget {
  const _ListTileShell({
    required this.child,
    required this.outline,
    this.onTap,
  });

  final Widget child;
  final Color outline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.l),
        border: Border.all(color: outline),
      ),
      child: child,
    );

    if (onTap == null) return card;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.l),
        child: card,
      ),
    );
  }
}
