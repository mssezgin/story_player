import 'dart:math' as math;

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

class CircularMultiProgressIndicator extends MultiProgressIndicator {
  const CircularMultiProgressIndicator({
    super.key,
    required super.maxValue,
    required super.value,
    super.backgroundColor,
    super.color,
    super.spacing,
    this.radius,
    this.strokeWidth = 4.0,
    this.strokeAlign = CircularProgressIndicator.strokeAlignCenter,
  });

  final double? radius;
  final double strokeWidth;
  final double strokeAlign;

  @override
  Widget build(BuildContext context) {
    double padAngle = math.pi * spacing / 180;
    double paddedArcAngle = 2 * math.pi / maxValue;
    double arcAngle = paddedArcAngle - padAngle;
    double arcAnglePercent = arcAngle / (2 * math.pi);
    return Stack(
      children: List<Widget>.generate(
        maxValue,
        (index) {
          if (index < value.floor()) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(padAngle / 2 + index * paddedArcAngle),
              child: SizedBox(
                width: radius,
                height: radius,
                child: CircularProgressIndicator(
                  value: arcAnglePercent,
                  backgroundColor: Colors.transparent,
                  color: color,
                  strokeWidth: strokeWidth,
                  strokeAlign: strokeAlign,
                ),
              ),
            );
          }
          if (index > value.floor()) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(padAngle / 2 + index * paddedArcAngle),
              child: SizedBox(
                width: radius,
                height: radius,
                child: CircularProgressIndicator(
                  value: arcAnglePercent,
                  backgroundColor: Colors.transparent,
                  color: backgroundColor,
                  strokeWidth: strokeWidth,
                  strokeAlign: strokeAlign,
                ),
              ),
            );
          }
          return Stack(
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(padAngle / 2 + index * paddedArcAngle),
                child: SizedBox(
                  width: radius,
                  height: radius,
                  child: CircularProgressIndicator(
                    value: (value - value.floor()) * arcAnglePercent,
                    backgroundColor: Colors.transparent,
                    color: color,
                    strokeWidth: strokeWidth,
                    strokeAlign: strokeAlign,
                  ),
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ((value - value.floor()) * arcAngle + padAngle / 2 + index * paddedArcAngle),
                child: SizedBox(
                  width: radius,
                  height: radius,
                  child: CircularProgressIndicator(
                    value: (1 - (value - value.floor())) * arcAnglePercent,
                    backgroundColor: Colors.transparent,
                    color: backgroundColor,
                    strokeWidth: strokeWidth,
                    strokeAlign: strokeAlign,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
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
