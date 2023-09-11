import 'package:flutter/material.dart';

class StoryGroup extends StatelessWidget {
  const StoryGroup({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      body: Center(
        child: Image.network('https://picsum.photos/1080/2160'),
      ),
    );
  }
}
