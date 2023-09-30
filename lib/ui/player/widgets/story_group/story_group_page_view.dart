import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/ui/player/pages/barrel.dart';
import 'package:story_player/ui/player/widgets/story_group/barrel.dart';

class StoryGroupPageView extends StatefulWidget {
  const StoryGroupPageView({
    super.key,
    required this.state,
    required this.onClose,
    this.pageTransform = const CubicPageTransform(),
  });

  final PlayerPlaying state;
  final VoidCallback onClose;
  final PageTransform pageTransform;

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
          context.read<PlayerBloc>().add(const PlayerPreviousUser(
            isControlled: false,
          ));
        } else if (value > state.currentUserIndex) {
          context.read<PlayerBloc>().add(const PlayerNextUser(
            isControlled: false,
          ));
        }
      },
      scrollDirection: Axis.horizontal,
      controller: state.controller,
      itemCount: state.users.length,
      itemBuilder: (context, index) {
        var page = BlocProvider(
          create: (context) => StoryGroupBloc(
            user: state.users[index],
            playerBloc: context.read<PlayerBloc>(),
          )
            ..add(StoryGroupPlay(isUnseenMode: state.isUnseenMode)),
          child: Center(
            child: StoryGroupPage(
              onClose: widget.onClose,
            ),
          ),
        );
        return pageTransform.transform(page, index, currentPageIndex, currentPageDelta);
      },
    );
  }
}
