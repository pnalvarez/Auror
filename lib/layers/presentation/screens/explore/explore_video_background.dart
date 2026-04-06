import 'dart:async' show TimeoutException, unawaited;

import 'package:auror/common/designsystem/organisms/feedback/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const Duration _kInitTimeout = Duration(seconds: 45);

/// Full-screen network video (cover). Empty [videoUrl] shows [placeholder].
///
/// When [showScrim] is true, a light top-to-bottom scrim improves contrast; set
/// false when text/overlays handle readability (e.g. TikTok-style feed).
class ExploreVideoBackground extends StatefulWidget {
  const ExploreVideoBackground({
    super.key,
    required this.videoUrl,
    this.placeholder,
    this.showScrim = true,
  });

  final String videoUrl;
  final Widget? placeholder;

  /// Subtle gradient over the video (not the rounded “card” overlay).
  final bool showScrim;

  @override
  State<ExploreVideoBackground> createState() => _ExploreVideoBackgroundState();
}

class _ExploreVideoBackgroundState extends State<ExploreVideoBackground> {
  VideoPlayerController? _controller;
  bool _failed = false;

  void _onControllerTick() {
    final c = _controller;
    if (c == null || !mounted) {
      return;
    }
    if (c.value.hasError) {
      _disposeController();
      setState(() => _failed = true);
    }
  }

  Future<void> _init(String url) async {
    _disposeController();
    final trimmed = url.trim();
    if (trimmed.isEmpty) {
      if (mounted) {
        setState(() => _failed = true);
      }
      return;
    }
    if (mounted) {
      setState(() => _failed = false);
    }
    final uri = Uri.parse(trimmed);
    final controller = VideoPlayerController.networkUrl(
      uri,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller = controller;
    controller.addListener(_onControllerTick);
    try {
      await controller.initialize().timeout(
        _kInitTimeout,
        onTimeout: () => throw TimeoutException('video init', _kInitTimeout),
      );
      if (!mounted) {
        return;
      }
      if (controller.value.hasError) {
        throw Exception(controller.value.errorDescription);
      }
      controller.setVolume(0);
      if (!mounted) {
        return;
      }
      controller
        ..setLooping(true)
        ..play();
      setState(() => _failed = false);
    } catch (_) {
      if (!mounted) {
        return;
      }
      _disposeController();
      setState(() => _failed = true);
    }
  }

  void _disposeController() {
    _controller?.removeListener(_onControllerTick);
    _controller?.dispose();
    _controller = null;
  }

  @override
  void initState() {
    super.initState();
    unawaited(_init(widget.videoUrl));
  }

  @override
  void didUpdateWidget(covariant ExploreVideoBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      unawaited(_init(widget.videoUrl));
    }
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final controller = _controller;
    final showVideo = !_failed &&
        controller != null &&
        controller.value.isInitialized &&
        controller.value.aspectRatio > 0;

    final hasUrl = widget.videoUrl.trim().isNotEmpty;
    final showLoading =
        !_failed && hasUrl && (controller == null || !controller.value.isInitialized);

    final fallback =
        widget.placeholder ?? _DefaultVideoPlaceholder(scheme: scheme);

    return Stack(
      fit: StackFit.expand,
      children: [
        if (showVideo)
          ColoredBox(
            color: Colors.black,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            ),
          )
        else
          fallback,
        if (widget.showScrim)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  scheme.surface.withValues(alpha: 0.2),
                  scheme.surface.withValues(alpha: 0.55),
                  scheme.surface.withValues(alpha: 0.75),
                ],
              ),
            ),
          ),
        if (showLoading)
          Center(
            child: CircularLoader(
              color: scheme.primary,
              size: 40,
              strokeWidth: 2,
            ),
          ),
      ],
    );
  }
}

class _DefaultVideoPlaceholder extends StatelessWidget {
  const _DefaultVideoPlaceholder({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: scheme.surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              scheme.surfaceContainerHighest,
              scheme.surface,
              scheme.surfaceContainerLow,
            ],
          ),
        ),
      ),
    );
  }
}
