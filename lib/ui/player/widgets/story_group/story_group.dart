import 'package:flutter/material.dart';
import 'package:story_player/repository/models/barrel.dart';

class StoryGroup extends StatelessWidget {
  const StoryGroup({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.black38,
      ),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Image.network(user.stories[0].fileSource),
    );
  }
}
