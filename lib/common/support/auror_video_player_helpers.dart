import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

/// Inline muted loops do not need to mix with other audio; `mixWithOthers:
/// true` has caused issues with macOS AVFoundation + textures.
VideoPlayerOptions aurorMutedLoopVideoPlayerOptions() {
  if (kIsWeb) {
    return VideoPlayerOptions();
  }
  return VideoPlayerOptions(mixWithOthers: false);
}

/// Workaround: first frame may not paint until the next frame (see Flutter
/// issues on macOS + [VideoPlayer]).
void scheduleMacOsVideoTextureRefresh(VoidCallback ifMountedSetState) {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.macOS) {
    return;
  }
  WidgetsBinding.instance.addPostFrameCallback((_) => ifMountedSetState());
}
