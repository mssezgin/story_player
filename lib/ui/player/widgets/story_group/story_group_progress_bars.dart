import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/ui/player/pages/barrel.dart';

class StoryGroupProgressBars extends StatelessWidget {
  const StoryGroupProgressBars({
    super.key,
    required this.user,
    required this.animationController,
  });

  final User user;
  final AnimationController animationController;

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
                        if (index < state.currentStoryIndex) {
                          return const LinearProgressIndicator(
                            value: 1,
                            color: Colors.white,
                            backgroundColor: Colors.white54,
                          );
                        }
                        if (index > state.currentStoryIndex) {
                          return const LinearProgressIndicator(
                            value: 0,
                            color: Colors.white,
                            backgroundColor: Colors.white54,
                          );
                        }
                        return AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              value: animationController.value,
                              color: Colors.white,
                              backgroundColor: Colors.white54,
                            );
                          },
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
