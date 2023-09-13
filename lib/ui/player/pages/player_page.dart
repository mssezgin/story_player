import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/ui/player/pages/barrel.dart';
import 'package:story_player/ui/player/widgets/story_group/barrel.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          if (state is PlayerInitial) {
            return const Text('There are no stories.');
          }
          if (state is PlayerLoading) {
            return const CircularProgressIndicator();
          }
          if (state is PlayerPlaying) {
            return PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return StoryGroup(
                  user: state.users[index],
                );
              },
            );
          }
          if (state is PlayerPaused) {
            return const Text('Paused.');
          }
          return const Text('Unknown Error');
        },
      ),
    );
  }
}
