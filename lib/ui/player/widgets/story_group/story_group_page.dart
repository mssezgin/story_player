import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/ui/player/widgets/story/barrel.dart';
import 'package:story_player/ui/player/widgets/story_group/barrel.dart';

class StoryGroupPage extends StatelessWidget {
  const StoryGroupPage({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryGroupBloc, StoryGroupState>(
      builder: (context, state) {
        if (state is StoryGroupLoading) {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        }
        if (state is StoryGroupSuccess) {
          return StoryPageView(
            state: state,
            onClose: onClose,
          );
        }
        if (state is StoryGroupError) {
          return Text(
            state.errorMessage,
            style: const TextStyle(color: Colors.white),
          );
        }
        return const Text(
          'Unknown Error',
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }
}
