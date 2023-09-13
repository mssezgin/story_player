import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_player/repository/barrel.dart';
import 'package:story_player/repository/services/barrel.dart';
import 'package:story_player/ui/home/pages/barrel.dart';
import 'package:story_player/ui/home/widgets/users/barrel.dart';

void main() {
  if (kReleaseMode) {
    debugPrint = (message, {wrapWidth}) {};
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        child: MaterialApp(
          title: 'Story Player',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          ),
          home: const HomeLayout(title: 'Story Player'),
        ),
      ),
    );
  }
}
