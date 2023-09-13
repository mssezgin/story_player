import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/repository/barrel.dart';
import 'package:story_player/repository/services/barrel.dart';
import 'package:story_player/ui/home/pages/barrel.dart';
import 'package:story_player/ui/home/widgets/users/barrel.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(
        userService: UserService(),
      ),
      child: BlocProvider(
        create: (context) => UserBloc(
          userRepository: context.read<UserRepository>(),
        )..add(const UserGetAll()),
        child: HomePage(title: title),
      ),
    );
  }
}
