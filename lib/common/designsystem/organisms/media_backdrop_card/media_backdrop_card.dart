import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Rounded surface with a **full-bleed** network image behind content, a bottom
/// dark gradient for legibility, and a title + optional italic quote.
///
/// Use for any media hero (courses, stories, highlights). Optional
/// [leadingLabel] and [trailingMeta] render a top row (e.g. category + progress)
/// without tying the widget to a specific domain.
class MediaBackdropCard extends StatelessWidget {
  const MediaBackdropCard({
    super.key,
    required this.title,
    required this.quote,
    required this.imageUrl,
    this.leadingLabel,
    this.trailingMeta,
    this.trailingMetaIcon,
    this.height = 320,
    this.borderRadius,
    this.onExpand,
  });

  final String title;
  final String quote;

  /// HTTPS (or supported) URL for the background image.
  final String imageUrl;

  /// Optional pill at the top start (e.g. category).
  final String? leadingLabel;

  /// Optional label at the top end (e.g. day counter), shown with [trailingMetaIcon].
  final String? trailingMeta;

  /// Defaults to [Icons.route_rounded] when [trailingMeta] is non-empty.
  final IconData? trailingMetaIcon;

  /// Total height of the card.
  final double height;

  /// Defaults to [AppRadius.xl2].
  final double? borderRadius;

  /// When non-null, a bottom-end chevron calls this (e.g. expand details).
  final VoidCallback? onExpand;

  bool get _hasTopRow {
    final lead = leadingLabel?.trim() ?? '';
    final trail = trailingMeta?.trim() ?? '';
    return lead.isNotEmpty || trail.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppRadius.xl2;
    final accent = AppColors.DarkContent.accent;
    final fallbackBg = AppColors.DarkContent.background;

    final titleStyle = headlineS.copyWith(
      color: Colors.white,
      height: 1.2,
    );
    final quoteStyle = body2Light.copyWith(
      color: accent,
      fontStyle: FontStyle.italic,
      height: 1.45,
    );

    final trimmedUrl = imageUrl.trim();

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: trimmedUrl.isEmpty
                  ? ColoredBox(color: fallbackBg)
                  : CachedNetworkImage(
                      imageUrl: trimmedUrl,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 200),
                      placeholder: (_, __) => ColoredBox(color: fallbackBg),
                      errorWidget: (_, __, ___) => ColoredBox(color: fallbackBg),
                    ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.88),
                    ],
                    stops: const [0.25, 1.0],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacings.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_hasTopRow)
                    _TopMetaRow(
                      leadingLabel: leadingLabel,
                      trailingMeta: trailingMeta,
                      trailingMetaIcon: trailingMetaIcon,
                      accent: accent,
                    ),
                  const Spacer(),
                  Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: titleStyle,
                  ),
                  if (quote.trim().isNotEmpty) ...[
                    const SizedBox(height: AppSpacings.s),
                    Text(
                      quote.trim(),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: quoteStyle,
                    ),
                  ],
                ],
              ),
            ),
            if (onExpand != null)
              Positioned(
                right: AppSpacings.m,
                bottom: AppSpacings.m,
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white.withValues(alpha: 0.9),
                    size: 28,
                  ),
                  onPressed: onExpand,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TopMetaRow extends StatelessWidget {
  const _TopMetaRow({
    required this.leadingLabel,
    required this.trailingMeta,
    required this.trailingMetaIcon,
    required this.accent,
  });

  final String? leadingLabel;
  final String? trailingMeta;
  final IconData? trailingMetaIcon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final lead = leadingLabel?.trim() ?? '';
    final trail = trailingMeta?.trim() ?? '';
    final icon = trailingMetaIcon ?? Icons.route_rounded;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lead.isNotEmpty)
          DecoratedBox(
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(AppRadius.full(28)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacings.s,
                vertical: AppSpacings.xs2,
              ),
              child: Text(
                lead,
                style: tagS.copyWith(
                  color: AppColors.DarkContent.background,
                  height: 1.2,
                ),
              ),
            ),
          ),
        const Spacer(),
        if (trail.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: accent),
              const SizedBox(width: AppSpacings.xs2),
              Text(
                trail,
                style: body2Medium.copyWith(color: accent, height: 1.2),
              ),
            ],
          ),
      ],
    );
  }
}
