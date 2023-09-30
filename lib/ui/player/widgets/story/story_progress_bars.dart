import 'package:flutter/material.dart';

class StoryProgressBars extends StatelessWidget {
  const StoryProgressBars({
    super.key,
    required this.currentIndex,
    required this.count,
    required this.animationController,
  });

  final int currentIndex;
  final int count;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: List.generate(
          count,
          (index) {
            return Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (index < currentIndex) {
                      return const LinearProgressIndicator(
                        value: 1,
                        color: Colors.white,
                        backgroundColor: Colors.white54,
                      );
                    }
                    if (index > currentIndex) {
                      return const LinearProgressIndicator(
                        value: 0,
                        color: Colors.white,
                        backgroundColor: Colors.white54,
                      );
                    }
                    return AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: animationController.value,
                          color: Colors.white,
                          backgroundColor: Colors.white54,
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
