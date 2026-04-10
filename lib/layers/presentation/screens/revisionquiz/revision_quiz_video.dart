import 'dart:async' show TimeoutException, unawaited;

import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/organisms/feedback/circular_loader.dart';
import 'package:auror/common/support/auror_video_player_helpers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Avoid hanging forever on slow / blocked hosts (spinner stuck on “loading”).
const Duration _kInitTimeout = Duration(seconds: 45);

/// Network video surface with a dark gradient fallback when [videoUrl] is empty
/// or playback fails to initialize.
class RevisionQuizVideo extends StatefulWidget {
  const RevisionQuizVideo({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<RevisionQuizVideo> createState() => _RevisionQuizVideoState();
}

class _RevisionQuizVideoState extends State<RevisionQuizVideo> {
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
    if (url.isEmpty) {
      setState(() => _failed = true);
      return;
    }
    final uri = Uri.parse(url);
    final controller = VideoPlayerController.networkUrl(
      uri,
      videoPlayerOptions: aurorMutedLoopVideoPlayerOptions(),
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
      setState(() {});
      scheduleMacOsVideoTextureRefresh(() {
        if (mounted) setState(() {});
      });
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
    unawaited(_init(widget.videoUrl.trim()));
  }

  @override
  void didUpdateWidget(covariant RevisionQuizVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      setState(() => _failed = false);
      unawaited(_init(widget.videoUrl.trim()));
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
    final c = _controller;

    final showVideo =
        !_failed &&
        c != null &&
        c.value.isInitialized &&
        c.value.aspectRatio > 0;

    /// Waiting on [VideoPlayerController.initialize] (or controller not yet set).
    final isBuffering =
        !_failed &&
        (c == null || !c.value.isInitialized);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xl2),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (showVideo)
              Center(
                child: AspectRatio(
                  aspectRatio: c.value.aspectRatio,
                  child: VideoPlayer(c),
                ),
              )
            else
              _VideoPlaceholderBackground(scheme: scheme),
            if (isBuffering)
              Center(
                child: CircularLoader(
                  color: scheme.primary,
                  size: 32,
                  strokeWidth: 2,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Gradient fill behind video — no play affordance so it is not confused with
/// the loading state (spinner only while [isBuffering]).
class _VideoPlaceholderBackground extends StatelessWidget {
  const _VideoPlaceholderBackground({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            scheme.surfaceContainerHighest,
            scheme.surface,
            scheme.surfaceContainerLow,
          ],
        ),
      ),
    );
  }
}
