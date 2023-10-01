import 'package:flutter/material.dart';

abstract class MultiProgressIndicator extends StatelessWidget {
  const MultiProgressIndicator({
    super.key,
    required this.maxValue,
    required this.value,
    this.backgroundColor,
    this.color,
    this.spacing = 4.0,
  });

  final int maxValue;
  final double value;
  final Color? backgroundColor;
  final Color? color;
  final double spacing;
}

class LinearMultiProgressIndicator extends MultiProgressIndicator {
  const LinearMultiProgressIndicator({
    super.key,
    required super.maxValue,
    required super.value,
    super.backgroundColor,
    super.color,
    super.spacing,
    this.minHeight,
  });

  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        maxValue * 2 - 1,
        (index) {
          if (index.isOdd) {
            return SizedBox(
              width: spacing,
            );
          }
          return Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (index ~/ 2 < value.floor()) {
                  return LinearProgressIndicator(
                    value: 1,
                    backgroundColor: backgroundColor,
                    color: color,
                    minHeight: minHeight,
                  );
                }
                if (index ~/ 2 > value.floor()) {
                  return LinearProgressIndicator(
                    value: 0,
                    backgroundColor: backgroundColor,
                    color: color,
                    minHeight: minHeight,
                  );
                }
                return LinearProgressIndicator(
                  value: value - value.floor(),
                  backgroundColor: backgroundColor,
                  color: color,
                  minHeight: minHeight,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
