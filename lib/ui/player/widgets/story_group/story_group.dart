import 'package:flutter/material.dart';
import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/ui/player/widgets/story_group/barrel.dart';
import 'package:video_player/video_player.dart';

class StoryGroup extends StatefulWidget {
  const StoryGroup({
    super.key,
    required this.user,
    required this.storyController,
    required this.onPlayPreviousStory,
    required this.onPlayNextStory,
    required this.onPlayPreviousUser,
    required this.onPlayNextUser,
    required this.onStop,
  });

  final User user;
  final PageController storyController;
  final VoidCallback onPlayPreviousStory;
  final VoidCallback onPlayNextStory;
  final VoidCallback onPlayPreviousUser;
  final VoidCallback onPlayNextUser;
  final VoidCallback onStop;

  @override
  State<StoryGroup> createState() => _StoryGroupState();
}

class _StoryGroupState extends State<StoryGroup> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.stop();
        animationController.reset();
        widget.onPlayNextStory();
      }
    });
    onStoryChanged(widget.storyController.initialPage);
  }

  @override
  void dispose() {
    animationController.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  void onStoryChanged(int value) {
    animationController.stop();
    animationController.reset();
    videoPlayerController?.dispose();
    videoPlayerController = null;

    var story = widget.user.stories[value];
    switch (story.storyType) {
      case StoryType.image:
        animationController.duration = story.duration;
        animationController.forward();
        setState(() {});
        break;
      case StoryType.video:
        videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(story.fileSource))
          ..initialize().then((value) {
            setState(() {});
            videoPlayerController!.play();
            animationController.duration = videoPlayerController!.value.duration;
            animationController.forward();
          });
        break;
    }
  }

  void onPause() {
    animationController.stop();
    videoPlayerController?.pause();
    setState(() {});
  }

  void onResume() {
    animationController.forward();
    videoPlayerController?.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    var storyController = widget.storyController;
    return GestureDetector(
      onTapUp: (details) {
        double screenWidth = MediaQuery.of(context).size.width;
        if (details.globalPosition.dx < screenWidth / 2) {
          widget.onPlayPreviousStory();
        } else {
          widget.onPlayNextStory();
        }
      },
      onLongPressStart: (details) {
        onPause();
      },
      onLongPressEnd: (details) {
        onResume();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${user.firstName} ${user.lastName}'),
          leading: CloseButton(
            onPressed: widget.onStop,
          ),
          actions: [
            IconButton(
              onPressed: widget.onPlayPreviousStory,
              icon: const Icon(Icons.navigate_before),
            ),
            IconButton(
              onPressed: (animationController.isAnimating)
                  ? onPause
                  : onResume,
              icon: (animationController.isAnimating)
                  ? const Icon(Icons.pause)
                  : const Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: widget.onPlayNextStory,
              icon: const Icon(Icons.navigate_next),
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.black38,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: StoryGroupProgressBars(
              user: user,
              animationController: animationController,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: PageView.builder(
          onPageChanged: onStoryChanged,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          controller: storyController,
          itemCount: user.stories.length,
          itemBuilder: (context, index) {
            switch (user.stories[index].storyType) {
              case StoryType.image:
                return Image(
                  image: NetworkImage(user.stories[index].fileSource),
                  fit: BoxFit.cover,
                );
              case StoryType.video:
                if (videoPlayerController == null || !videoPlayerController!.value.isInitialized) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                return Center(
                  child: AspectRatio(
                    aspectRatio: videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController!),
                  ),
                );
              default:
                return const Center(
                  child: Text(
                    'Unsupported story type.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
