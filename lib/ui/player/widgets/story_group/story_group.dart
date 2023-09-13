import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/repository/models/barrel.dart';
import 'package:story_player/ui/player/pages/barrel.dart';

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
        leading: CloseButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<PlayerBloc>().add(const PlayerStop());
          },
        ),
        elevation: 0,
        backgroundColor: Colors.black38,
      ),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Center(child: Image.network(user.stories[0].fileSource)),
    );
  }
}
