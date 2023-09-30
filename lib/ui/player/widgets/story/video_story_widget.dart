import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoStoryWidget extends StatelessWidget {
  const VideoStoryWidget({
    super.key,
    this.videoPlayerController,
  });

  final VideoPlayerController? videoPlayerController;

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null || !videoPlayerController!.value.isInitialized) {
      return const CircularProgressIndicator(
        color: Colors.white,
      );
    }
    return AspectRatio(
      aspectRatio: videoPlayerController!.value.aspectRatio,
      child: VideoPlayer(videoPlayerController!),
    );
  }
}
