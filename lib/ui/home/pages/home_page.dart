import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/ui/home/widgets/users/barrel.dart';
import 'package:story_player/ui/player/pages/barrel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  void startPlayer(BuildContext context, bool isUnseenMode, int startUserIndex) {
    context.read<PlayerBloc>().add(
      PlayerPlay(
        isUnseenMode: isUnseenMode,
        startUserIndex: startUserIndex,
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlayerPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserBloc>().add(const UserGenerateRandomList());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Generated random users. Please refresh.'),
                ),
              );
            },
            icon: const Icon(Icons.shuffle),
          ),
          IconButton(
            onPressed: () {
              context.read<UserBloc>().add(const UserGetAllWithAllStories());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: UserList(startPlayer: startPlayer),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startPlayer(context, true, 0),
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
