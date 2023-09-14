import 'package:flutter/material.dart';
import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/ui/player/widgets/story_group/barrel.dart';

class StoryGroup extends StatelessWidget {
  const StoryGroup({
    super.key,
    required this.user,
    required this.storyController,
    required this.onPlayPreviousStory,
    required this.onPlayNextStory,
    required this.onPlayPreviousUser,
    required this.onPlayNextUser,
    required this.onPause,
    required this.onResume,
    required this.onStop,
  });

  final User user;
  final PageController storyController;
  final VoidCallback onPlayPreviousStory;
  final VoidCallback onPlayNextStory;
  final VoidCallback onPlayPreviousUser;
  final VoidCallback onPlayNextUser;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
        leading: CloseButton(
          onPressed: onStop,
        ),
        actions: [
          IconButton(
            onPressed: onPlayPreviousStory,
            icon: const Icon(Icons.navigate_before),
          ),
          IconButton(
            onPressed: onPause,
            icon: const Icon(Icons.pause),
          ),
          IconButton(
            onPressed: onPlayNextStory,
            icon: const Icon(Icons.navigate_next),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.black38,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: StoryGroupProgressBars(user: user),
        ),
      ),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        controller: storyController,
        itemCount: user.stories.length,
        itemBuilder: (context, index) {
          switch (user.stories[index].storyType) {
            case StoryType.image:
              return Image.network(user.stories[index].fileSource);
            case StoryType.video:
              return const Text('Video');
            default:
              return const Text('Unsupported story type.');
          }
        },
      ),
    );
  }
}
