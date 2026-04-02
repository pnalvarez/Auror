import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/font_sizes.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Top navigation row: [leadingIcon], then [title] and [description] stacked below
/// the leading icon; [trailingIcon] sits on the same row as the leading icon
/// (top-aligned).
///
/// Implements [PreferredSizeWidget] so it can be used as [Scaffold.appBar].
class DsNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const DsNavigationBar({
    super.key,
    this.leadingIcon,
    required this.title,
    this.description,
    this.trailingIcon,
    this.leadingIconColor,
    this.trailingIconColor,
    this.leadingIconSize = 32,
    this.trailingIconSize = 32,
    this.onTap,
  });

  final IconData? leadingIcon;
  final String title;

  /// When null or empty, only the title line is shown under the leading icon.
  final String? description;
  final IconData? trailingIcon;

  /// Defaults to [AppColors.DarkContent.accent] when null.
  final Color? leadingIconColor;

  /// Defaults to [ColorScheme.onSurfaceVariant] when null.
  final Color? trailingIconColor;

  final double leadingIconSize;
  final double trailingIconSize;
  final VoidCallback? onTap;

  /// Matches the vertical space used by [build] (max lines for title/description).
  @override
  Size get preferredSize => Size.fromHeight(_preferredHeight);

  double get _preferredHeight {
    final hasDescription =
        description != null && description!.trim().isNotEmpty;
    const verticalPadding = AppSpacings.m * 2;
    final iconAndGap = leadingIconSize + AppSpacings.s;
    // [headingH1] with height 1.2, max 2 lines (see [build]).
    const titleBlockHeight = defaultXL2 * 1.2 * 2;
    var height = verticalPadding + iconAndGap + titleBlockHeight;
    if (hasDescription) {
      // [body4Light] with height 1.25, max 3 lines (see [build]).
      height += AppSpacings.xs + defaultBody * 1.25 * 3;
    }
    if (onTap != null) {
      height += AppSpacings.xs * 2;
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final leadColor = leadingIconColor ?? AppColors.Inverse.onInverseSurface;
    final trailColor = trailingIconColor ?? AppColors.Inverse.onInverseSurface;

    final titleStyle = headingH2.copyWith(color: scheme.onSurface, height: 1.2);
    final descriptionStyle = body4Light.copyWith(
      color: scheme.onSurfaceVariant,
      height: 1.25,
    );

    final hasDescription =
        description != null && description!.trim().isNotEmpty;

    final headerRow = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacings.m,
              horizontal: AppSpacings.l,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingIcon != null) ...[
                  Icon(leadingIcon, size: leadingIconSize, color: leadColor),
                  const SizedBox(height: AppSpacings.s),
                ],
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
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: descriptionStyle,
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacings.m),
        Icon(trailingIcon, size: trailingIconSize, color: trailColor),
      ],
    );

    final Widget header;
    if (onTap == null) {
      header = headerRow;
    } else {
      header = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacings.s),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacings.xs,
            horizontal: AppSpacings.xs2,
          ),
          child: headerRow,
        ),
      );
    }

    return header;
  }
}
