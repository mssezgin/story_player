import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/ui/home/widgets/users/barrel.dart';
import 'package:story_player/ui/player/pages/barrel.dart';
import 'package:story_player/ui/player/widgets/story_group/barrel.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<PlayerBloc, PlayerState>(
        listener: (context, state) {
          if (state is PlayerInitial) {
            Navigator.pop(context);
            context.read<UserBloc>().add(const UserGetAllWithAllStories());
          }
        },
        builder: (context, state) {
          if (state is PlayerLoading) {
            return const CircularProgressIndicator();
          }
          if (state is PlayerPlaying) {
            return StoryGroupPageView(state: state);
          }
          if (state is PlayerPaused) {
            return const Text('Paused.');
          }
          return const SizedBox();
        },
      ),
    );
  }
}
