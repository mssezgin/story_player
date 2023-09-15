import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/ui/player/pages/barrel.dart';
import 'package:story_player/ui/player/widgets/story_group/barrel.dart';

class StoryGroupPageView extends StatefulWidget {
  const StoryGroupPageView({
    super.key,
    required this.state,
  });

  final PlayerPlaying state;
  final PageTransform pageTransform = const CubicPageTransform();

  @override
  State<StoryGroupPageView> createState() => _StoryGroupPageViewState();
}

class _StoryGroupPageViewState extends State<StoryGroupPageView> {
  late int currentPageIndex;
  double currentPageDelta = 0;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.state.controller.initialPage;
    widget.state.controller.addListener(() {
      setState(() {
        currentPageIndex = widget.state.controller.page!.floor();
        currentPageDelta = widget.state.controller.page! - currentPageIndex;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = widget.state;
    var pageTransform = widget.pageTransform;
    return PageView.builder(
      onPageChanged: (value) {
        if (value < state.currentUserIndex) {
          context.read<PlayerBloc>().add(const PlayerPreviousUser());
        } else if (value > state.currentUserIndex) {
          context.read<PlayerBloc>().add(const PlayerNextUser());
        }
      },
      scrollDirection: Axis.horizontal,
      controller: state.controller,
      itemCount: state.users.length,
      itemBuilder: (context, index) {
        var storyGroup = StoryGroup(
          user: state.users[index],
          storyController: state.userControllers[index],
          onPlayPreviousStory: () {
            context.read<PlayerBloc>().add(const PlayerPreviousStory());
          },
          onPlayNextStory: () {
            context.read<PlayerBloc>().add(const PlayerNextStory());
          },
          onPlayPreviousUser: () {
            context.read<PlayerBloc>().add(const PlayerPreviousUser());
          },
          onPlayNextUser: () {
            context.read<PlayerBloc>().add(const PlayerNextUser());
          },
          onPause: () {
            // debugPrint('onPause');
          },
          onResume: () {
            // debugPrint('onResume');
          },
          onStop: () {
            context.read<PlayerBloc>().add(const PlayerStop());
          },
        );
        return pageTransform.transform(storyGroup, index, currentPageIndex, currentPageDelta);
      },
    );
  }
}
