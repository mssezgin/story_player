import 'package:flutter/material.dart';

class ImageStoryWidget extends StatelessWidget {
  const ImageStoryWidget({
    super.key,
    required this.source,
  });

  final String source;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(source),
      fit: BoxFit.contain,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame == null) {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        }
        return child;
      },
    );
  }
}
