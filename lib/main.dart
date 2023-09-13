import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:story_player/ui/home/pages/barrel.dart';

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
    return MaterialApp(
      title: 'Story Player',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HomeLayout(title: 'Story Player'),
    );
  }
}
