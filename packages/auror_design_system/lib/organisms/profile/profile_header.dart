import 'package:auror_design_system/atoms/colors/colors.dart';
import 'package:auror_design_system/atoms/spacing/spacings.dart';
import 'package:auror_design_system/atoms/typography/typography.dart';
import 'package:flutter/material.dart';

/// Vertically stacked profile block: avatar (network or design-system default),
/// display name, and email with mail icon.
///
/// When [imageUrl] is null, empty, or fails to load, a circular placeholder is
/// shown using [AppColors.DarkContent] on dark themes and tertiary tones on light.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.imageUrl,
    required this.name,
    required this.email,
    this.avatarSize = 96,
    this.avatarRingColor,
    this.avatarRingWidth = 2,
    this.emailIconColor,
  });

  final String? imageUrl;
  final String name;
  final String email;
  final double avatarSize;

  /// When non-null, draws a circular ring outside the avatar (e.g. brand gold).
  final Color? avatarRingColor;

  final double avatarRingWidth;

  /// When null, uses [ColorScheme.onSurfaceVariant] for the mail icon.
  final Color? emailIconColor;

  bool get _hasUrl => imageUrl != null && imageUrl!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: _ProfileAvatar(
            imageUrl: _hasUrl ? imageUrl!.trim() : null,
            size: avatarSize,
            ringColor: avatarRingColor,
            ringWidth: avatarRingWidth,
          ),
        ),
        const SizedBox(height: AppSpacings.l),
        Text(
          name,
          textAlign: TextAlign.center,
          style: headlineM.copyWith(color: scheme.onSurface),
        ),
        const SizedBox(height: AppSpacings.s),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                Icons.mail_outline_rounded,
                size: 18,
                color: emailIconColor ?? scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: AppSpacings.xs),
            Flexible(
              child: Text(
                email,
                textAlign: TextAlign.center,
                style: body2Light.copyWith(color: scheme.onSurfaceVariant),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.imageUrl,
    required this.size,
    this.ringColor,
    this.ringWidth = 2,
  });

  final String? imageUrl;
  final double size;
  final Color? ringColor;
  final double ringWidth;

  @override
  Widget build(BuildContext context) {
    final placeholder = _DefaultProfileAvatar(size: size);
    final inner = imageUrl == null
        ? placeholder
        : ClipOval(
            child: SizedBox(
              width: size,
              height: size,
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return placeholder;
                },
                errorBuilder: (_, _, _) => placeholder,
              ),
            ),
          );

    if (ringColor == null) return inner;

    return Container(
      padding: EdgeInsets.all(ringWidth),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ringColor!, width: ringWidth),
      ),
      child: inner,
    );
  }
}

class _DefaultProfileAvatar extends StatelessWidget {
  const _DefaultProfileAvatar({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final Color bg;
    final Color iconColor;
    if (brightness == Brightness.dark) {
      bg = AppColors.DarkContent.surface;
      iconColor = AppColors.DarkContent.accent;
    } else {
      bg = Color.lerp(
        AppColors.Surface.surfaceContainerHigh,
        AppColors.Tertiary.tertiaryContainer,
        0.4,
      )!;
      iconColor = AppColors.Tertiary.tertiary;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(
        Icons.person_outline_rounded,
        size: size * 0.45,
        color: iconColor,
      ),
    );
  }
}
