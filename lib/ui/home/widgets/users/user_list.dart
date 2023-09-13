import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/ui/home/widgets/users/barrel.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return const Text('There are no stories.');
        }
        if (state is UserLoading) {
          return const CircularProgressIndicator();
        }
        if (state is UserSuccess) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return UserListItem(
                user: state.users[index],
                onStartPlayingStories: () {
                  debugPrint('Playing stories, starting from ${state.users[index].fullName}');
                },
              );
            },
          );
        }
        if (state is UserError) {
          return Text(state.errorMessage);
        }
        return const Text('Unknown Error');
      },
    );
  }
}
