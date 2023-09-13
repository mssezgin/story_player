import 'package:flutter/material.dart';
import 'package:story_player/ui/home/pages/barrel.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return HomePage(title: title);
  }
}
