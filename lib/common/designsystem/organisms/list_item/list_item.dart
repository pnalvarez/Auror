import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Input model for [ListItem]: each subtype defines the inner layout; the shell
/// applies padding, surface, border, and tap behavior (same pattern as mibook).
abstract class ListItemInput {
  ListItemInput();

  Widget buildContent(BuildContext context);
}

/// Horizontal row: leading icon, title + optional description, optional chevron.
class IconTitleDescriptionInput extends ListItemInput {
  IconTitleDescriptionInput({
    required this.leadingIcon,
    required this.title,
    this.description,
    this.showTrailing = true,
    this.leadingIconColor,
  });

  final IconData leadingIcon;
  final String title;

  /// When null or empty, only the title row is shown (e.g. navigation-only rows).
  final String? description;

  final bool showTrailing;

  /// Defaults to [AppColors.DarkContent.accent] when null (profile / dark gold).
  final Color? leadingIconColor;

  static const double _iconSize = 24;

  @override
  Widget buildContent(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final titleStyle = headingH6.copyWith(color: scheme.onSurface, height: 1.2);
    final descriptionStyle = body4Light.copyWith(
      color: scheme.onSurfaceVariant,
      height: 1.25,
    );

    final iconColor = leadingIconColor ?? AppColors.DarkContent.accent;
    final hasDescription =
        description != null && description!.trim().isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(leadingIcon, size: _iconSize, color: iconColor),
        const SizedBox(width: AppSpacings.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: titleStyle,
              ),
              if (hasDescription) ...[
                const SizedBox(height: AppSpacings.xs),
                Text(
                  description!.trim(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: descriptionStyle,
                ),
              ],
            ],
          ),
        ),
        if (showTrailing) ...[
          const SizedBox(width: AppSpacings.s),
          Icon(
            Icons.chevron_right_rounded,
            size: 22,
            color: scheme.onSurfaceVariant,
          ),
        ],
      ],
    );
  }
}

/// Horizontal row: leading icon, single line of text ([body2Light] on [onSurface]),
/// optional chevron. Same shell spacing as [IconTitleDescriptionInput] without a
/// subtitle line.
class IconDescriptionInput extends ListItemInput {
  IconDescriptionInput({
    required this.leadingIcon,
    required this.title,
    this.showTrailing = true,
    this.leadingIconColor,
  });

  final IconData leadingIcon;
  final String title;
  final bool showTrailing;
  final Color? leadingIconColor;

  static const double _iconSize = 24;

  @override
  Widget buildContent(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final iconColor = leadingIconColor ?? AppColors.DarkContent.accent;
    final titleStyle = body3Light.copyWith(
      color: scheme.onSurface,
      height: 1.25,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(leadingIcon, size: _iconSize, color: iconColor),
        const SizedBox(width: AppSpacings.m),
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: titleStyle,
          ),
        ),
        if (showTrailing) ...[
          const SizedBox(width: AppSpacings.s),
          Icon(
            Icons.chevron_right_rounded,
            size: 22,
            color: scheme.onSurfaceVariant,
          ),
        ],
      ],
    );
  }
}

/// Escape hatch: wrap any [Widget] as a [ListItem] body.
class GenericListItemInput extends ListItemInput {
  GenericListItemInput({required this.child});

  final Widget child;

  @override
  Widget buildContent(BuildContext context) => child;
}

/// Card shell around a [ListItemInput]; dispatches layout by input type via
/// [ListItemInput.buildContent].
class ListItem extends StatelessWidget {
  // Non-const so [ListItemInput] models can evolve without hot-reload failures.
  // ignore: prefer_const_constructors_in_immutables
  ListItem({
    super.key,
    required this.input,
    this.isExpanded = false,
    this.onTap,
  });

  final ListItemInput input;
  final bool isExpanded;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final padded = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.l,
        vertical: AppSpacings.m,
      ),
      child: input.buildContent(context),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.35)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          child: isExpanded
              ? SizedBox(width: double.infinity, child: padded)
              : padded,
        ),
      ),
    );
  }
}
