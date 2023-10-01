import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/ui/player/widgets/story/barrel.dart';
import 'package:story_player/ui/player/widgets/story_group/barrel.dart';
import 'package:video_player/video_player.dart';

class StoryPageView extends StatefulWidget {
  const StoryPageView({
    super.key,
    required this.state,
    required this.onClose,
  });

  final StoryGroupSuccess state;
  final VoidCallback onClose;

  @override
  State<StoryPageView> createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> with SingleTickerProviderStateMixin {
  late final StoryGroupBloc storyGroupBloc;
  late AnimationController animationController;
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    storyGroupBloc = context.read<StoryGroupBloc>();
    animationController = AnimationController(vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.stop();
        animationController.reset();
        playNextStory();
      }
    });
    onStoryChanged(widget.state.currentStory);
  }

  @override
  void dispose() {
    animationController.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  void playPreviousStory() {
    storyGroupBloc.add(const StoryGroupPreviousStory());
  }

  void playNextStory() {
    storyGroupBloc.add(const StoryGroupNextStory());
  }

  void pause() {
    setState(() {
      animationController.stop();
      videoPlayerController?.pause();
    });
  }

  void resume() {
    setState(() {
      animationController.forward();
      videoPlayerController?.play();
    });
  }

  void onStoryChanged(Story story) {
    animationController.stop();
    animationController.reset();
    videoPlayerController?.dispose();
    videoPlayerController = null;
    story.markSeen();

    switch (story.storyType) {
      case StoryType.image:
        setState(() {
          animationController.duration = story.duration;
          animationController.forward();
        });
      case StoryType.video:
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(story.fileSource),
        )..initialize().then((value) {
          setState(() {
            videoPlayerController!.play();
            animationController.duration = videoPlayerController!.value.duration;
            animationController.forward();
          });
        });
    }
  }

  Widget buildStory(Story story) {
    switch (story.storyType) {
      case StoryType.image:
        return ImageStoryWidget(
          source: story.fileSource,
        );
      case StoryType.video:
        return VideoStoryWidget(
          videoPlayerController: videoPlayerController,
        );
      default:
        return const Center(
          child: Text(
            'Unsupported story type.',
            style: TextStyle(color: Colors.white),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoryGroupBloc, StoryGroupState>(
      listenWhen: (previous, current) {
        if (current is! StoryGroupSuccess) {
          return false;
        }
        if (previous is! StoryGroupSuccess) {
          return true;
        }
        return previous.currentStoryIndex != current.currentStoryIndex;
      },
      listener: (context, state) {
        if (state is StoryGroupSuccess) {
          onStoryChanged(state.currentStory);
        }
      },
      child: GestureDetector(
        onTapUp: (details) {
          double screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            playPreviousStory();
          } else {
            playNextStory();
          }
        },
        onLongPressStart: (details) {
          pause();
        },
        onLongPressEnd: (details) {
          resume();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.state.user.fullName),
            leading: CloseButton(
              onPressed: widget.onClose,
            ),
            elevation: 0,
            backgroundColor: Colors.black38,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(8),
              child: StoryProgressBars(
                currentIndex: widget.state.currentStoryIndex,
                count: widget.state.user.stories.length,
                animationController: animationController,
              ),
            ),
          ),
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          body: Center(
            child: buildStory(widget.state.currentStory),
          ),
        ),
      ),
    );
  }
}
