import 'package:flutter/material.dart';
import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/ui/player/widgets/story_group/story_group.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({
    super.key,
    required this.isUnseenMode,
    required this.users,
  });

  final bool isUnseenMode;
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: users.length,
      itemBuilder: (context, index) {
        return StoryGroup(
          user: users[index],
        );
      },
    );
  }
}
