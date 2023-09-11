import 'package:flutter/material.dart';
import 'package:story_player/ui/player/widgets/story_group/story_group.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryGroup(title: 'Story Group #0');
  }
}
