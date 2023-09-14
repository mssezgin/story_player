import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/ui/player/pages/barrel.dart';

class StoryGroupProgressBars extends StatelessWidget {
  const StoryGroupProgressBars({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state is PlayerPlaying) {
          return Row(
            children: List.generate(
              user.stories.length,
                  (index) {
                return Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return LinearProgressIndicator(
                          value: (index < state.currentStoryIndex)
                              ? 100
                              : (index > state.currentStoryIndex)
                              ? 0
                              : 0.5,
                          color: Colors.white,
                          backgroundColor: Colors.white54,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
