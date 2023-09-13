import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/ui/home/widgets/users/barrel.dart';
import 'package:story_player/ui/player/pages/player_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('Generate random users');
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
              debugPrint('Refresh');
              context.read<UserBloc>().add(const UserGetAll());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: const Center(
        child: UserList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const PlayerPage(
                  isUnseenMode: false,
                  users: [],
                );
              },
            ),
          );
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
