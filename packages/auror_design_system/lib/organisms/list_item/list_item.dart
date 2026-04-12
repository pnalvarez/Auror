import 'package:auror_design_system/atoms/spacing/radius.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:auror_design_system/molecules/badges/badge.dart';
import 'package:auror_design_system/molecules/buttons/action_buttons.dart';
import 'package:auror_design_system/molecules/buttons/button_brand.dart';
import 'package:auror_design_system/molecules/progress/step_progress_bar.dart';
import 'package:auror_design_system/organisms/list_item/list_item_brand.dart';
import 'package:flutter/material.dart' hide Badge;

export 'list_item_brand.dart';

const double _kListItemDisabledOpacity = 0.5;

/// Input model for [ListItem]: each subtype defines the inner layout; the shell
/// applies padding, surface, border, and tap behavior (same pattern as mibook).
abstract class ListItemInput {
  ListItemInput();

  Widget buildContent(BuildContext context);
}

class TextInput extends ListItemInput {
  TextInput({required this.text});

  final String text;

  @override
  Widget buildContent(BuildContext context) {
    final brandStyle = ListItemBrandScope.of(context);
    return Text(
      text,
      style: body4Medium.copyWith(color: brandStyle.titleTextColor),
    );
  }
}

/// Horizontal row: leading icon, title + optional description, optional chevron.
class IconTitleDescriptionInput extends ListItemInput {
  IconTitleDescriptionInput({
    required this.leadingIcon,
    required this.title,
    this.description,
    this.descriptionLeadingIcon,
    this.showTrailing = true,
    this.leadingIconColor,
  });

  final IconData leadingIcon;
  final String title;

  /// When null or empty, only the title row is shown (e.g. navigation-only rows).
  final String? description;

  /// Shown before [description] when set; uses the same color as the description text.
  final IconData? descriptionLeadingIcon;

  final bool showTrailing;

  /// Defaults to [ListItemBrand.neutral] leading color when null.
  final Color? leadingIconColor;

  static const double _iconSize = 24;
  static const double _descriptionLeadingIconSize = 16;

  @override
  Widget buildContent(BuildContext context) {
    final brandStyle = ListItemBrandScope.of(context);
    final descriptionColor = brandStyle.bodyTextColor;

    final titleStyle = headingH6.copyWith(
      color: brandStyle.titleTextColor,
      height: 1.2,
    );
    final descriptionStyle = body4Light.copyWith(
      color: descriptionColor,
      height: 1.25,
    );

    final iconColor = leadingIconColor ?? brandStyle.leadingIconColor;
    final hasDescription =
        description != null && (description ?? '').trim().isNotEmpty;

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (descriptionLeadingIcon != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          descriptionLeadingIcon,
                          size: _descriptionLeadingIconSize,
                          color: descriptionColor,
                        ),
                      ),
                      const SizedBox(width: AppSpacings.xs),
                    ],
                    Expanded(
                      child: Text(
                        (description ?? '').trim(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: descriptionStyle,
                      ),
                    ),
                  ],
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
            color: brandStyle.trailingIconColor,
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
    final brandStyle = ListItemBrandScope.of(context);
    final iconColor = leadingIconColor ?? brandStyle.leadingIconColor;
    final titleStyle = body3Light.copyWith(
      color: brandStyle.titleTextColor,
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
            color: brandStyle.trailingIconColor,
          ),
        ],
      ],
    );
  }
}

/// Vertical stack: optional leading icon before the title, then a paragraph
/// ([body2Light]). No chevron — for informational cards (e.g. expected answer).
class IconTitleParagraphInput extends ListItemInput {
  IconTitleParagraphInput({
    this.leadingIcon,
    required this.title,
    required this.description,
    this.leadingIconColor,
  });

  /// Shown before [title] when non-null; omitted when null.
  final IconData? leadingIcon;

  final String title;
  final String description;

  /// Defaults to [ListItemBrand] leading color when null.
  final Color? leadingIconColor;

  static const double _iconSize = 24;

  @override
  Widget buildContent(BuildContext context) {
    final brandStyle = ListItemBrandScope.of(context);
    final titleStyle = body3Semibold.copyWith(
      color: brandStyle.titleTextColor,
      height: 1.2,
    );
    final descriptionStyle = body2Light.copyWith(
      color: brandStyle.bodyTextColor,
      height: 1.45,
    );
    final iconColor = leadingIconColor ?? brandStyle.leadingIconColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: _iconSize, color: iconColor),
              const SizedBox(width: AppSpacings.s),
            ],
            Expanded(child: Text(title, style: titleStyle)),
          ],
        ),
        const SizedBox(height: AppSpacings.s),
        Text(description, style: descriptionStyle),
      ],
    );
  }
}

/// Card row: top badges ([DsBadge] category + optional premium), title, body,
/// trailing icon (e.g. lock).
class BadgesTitleDescriptionInput extends ListItemInput {
  BadgesTitleDescriptionInput({
    required this.topMainBadgeText,
    this.topSecondBadgeText,
    this.secondBadgeIcon = Icons.workspace_premium_outlined,
    required this.title,
    required this.description,
    required this.trailingIcon,
    this.trailingIconSize = 22,
  });

  final String topMainBadgeText;

  /// When null or empty, only [topMainBadgeText] is shown in the badge row.
  final String? topSecondBadgeText;

  /// Icon for the second badge (premium row). Ignored when [topSecondBadgeText] is empty.
  final IconData secondBadgeIcon;

  final String title;
  final String description;
  final IconData trailingIcon;
  final double trailingIconSize;

  @override
  Widget buildContent(BuildContext context) {
    final brandStyle = ListItemBrandScope.of(context);
    final hasSecond =
        topSecondBadgeText != null && topSecondBadgeText!.trim().isNotEmpty;

    final titleStyle = headingH6.copyWith(
      color: brandStyle.titleTextColor,
      height: 1.2,
    );
    final descriptionStyle = body4Light.copyWith(
      color: brandStyle.bodyTextColor,
      height: 1.35,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Wrap(
                spacing: AppSpacings.s,
                runSpacing: AppSpacings.s,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  DsBadge(
                    label: topMainBadgeText,
                    variant: BadgeVariant.neutral,
                  ),
                  if (hasSecond)
                    DsBadge(
                      label: topSecondBadgeText!.trim(),
                      leadingIcon: secondBadgeIcon,
                      variant: BadgeVariant.highlight,
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacings.s),
            Icon(
              trailingIcon,
              size: trailingIconSize,
              color: brandStyle.trailingIconColor,
            ),
          ],
        ),
        const SizedBox(height: AppSpacings.m),
        Text(title, style: titleStyle),
        const SizedBox(height: AppSpacings.s),
        Text(description, style: descriptionStyle),
      ],
    );
  }
}

/// Top row: title + optional description, [PrimaryButton] (brand primary) with
/// chevron; divider; [StepProgressBar] with current/total.
class TitleDescriptionCTAProgressInput extends ListItemInput {
  TitleDescriptionCTAProgressInput({
    required this.title,
    this.description,
    required this.ctaText,
    required this.onCtaTap,
    required this.currentProgress,
    required this.totalProgress,
  });

  final String title;

  /// When null or empty, only [title] is shown in the text column.
  final String? description;

  final String ctaText;
  final VoidCallback onCtaTap;
  final int currentProgress;
  final int totalProgress;

  @override
  Widget buildContent(BuildContext context) {
    final brandStyle = ListItemBrandScope.of(context);
    final scheme = Theme.of(context).colorScheme;
    final hasDescription =
        description != null && (description ?? '').trim().isNotEmpty;

    final titleStyle = headingH6.copyWith(
      color: brandStyle.titleTextColor,
      height: 1.2,
    );
    final descriptionStyle = body4Light.copyWith(
      color: brandStyle.bodyTextColor,
      height: 1.25,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: titleStyle),
            if (hasDescription) ...[
              const SizedBox(height: AppSpacings.xs),
              Text((description ?? '').trim(), style: descriptionStyle),
            ],
          ],
        ),
        const SizedBox(height: AppSpacings.m),
        Divider(height: 1, thickness: 1, color: scheme.outline),
        const SizedBox(height: AppSpacings.m),
        StepProgressBar(
          currentValue: currentProgress,
          totalValue: totalProgress,
        ),
        const SizedBox(height: AppSpacings.l),
        PrimaryButton(
          label: ctaText,
          action: onCtaTap,
          brand: ButtonBrand.primary,
          trailingIcon: Icons.chevron_right_rounded,
        ),
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
    this.brand = ListItemBrand.neutral,
    this.isExpanded = false,
    this.onTap,
    this.padding,
    this.isSelected = false,
    this.isEnabled = true,
  });

  final ListItemInput input;

  /// Border, background, and default text/icon colors for the shell and inner
  /// [ListItemInput] layouts.
  final ListItemBrand brand;

  final bool isExpanded;
  final VoidCallback? onTap;

  /// Defaults to horizontal [AppSpacings.l], vertical [AppSpacings.m].
  final EdgeInsetsGeometry? padding;

  /// Highlights the card border with [ColorScheme.primary].
  final bool isSelected;

  /// When false, inner content is drawn at reduced opacity and [onTap] is ignored.
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final brandStyle = ListItemBrandStyle.resolve(brand, scheme);

    final resolvedPadding =
        padding ??
        const EdgeInsets.symmetric(
          horizontal: AppSpacings.l,
          vertical: AppSpacings.m,
        );

    // [ListItemBrandScope] must be an *ancestor* of the context passed to
    // [ListItemInput.buildContent], or [ListItemBrandScope.of] falls back to
    // neutral and picks theme onSurface (e.g. white on dark themes).
    Widget body(BuildContext rowContext) {
      return Padding(
        padding: resolvedPadding,
        child: input.buildContent(rowContext),
      );
    }

    Widget content = isExpanded
        ? SizedBox(
            width: double.infinity,
            child: Builder(builder: body),
          )
        : Builder(builder: body);

    if (!isEnabled) {
      content = Opacity(opacity: _kListItemDisabledOpacity, child: content);
    }

    return ListItemBrandScope(
      style: brandStyle,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: brandStyle.backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.m),
          border: Border.all(
            color: isSelected ? scheme.primary : brandStyle.borderColor,
            width: isSelected ? 2 : brandStyle.borderWidth,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: isEnabled ? onTap : null,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: content,
          ),
        ),
      ),
    );
  }
}
