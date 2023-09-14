import 'dart:math';

import 'package:flutter/material.dart';

abstract class PageTransform {
  Widget transform(Widget page, int index, int currentPageIndex, double currentPageDelta);
}

class CubicPageTransform implements PageTransform {
  const CubicPageTransform({
    this.perspectiveScale = 0.0014,
    this.rightPageAlignment = Alignment.centerLeft,
    this.leftPageAlignment = Alignment.centerRight,
    double rotationAngle = 90,
  }) : rotationAngle = pi / 180 * rotationAngle;

  final double perspectiveScale;
  final AlignmentGeometry rightPageAlignment;
  final AlignmentGeometry leftPageAlignment;
  final double rotationAngle;

  @override
  Widget transform(Widget page, int index, int currentPageIndex, double currentPageDelta) {
    if (index == currentPageIndex) {
      return Transform(
        alignment: leftPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(rotationAngle * currentPageDelta),
        child: page,
      );
    } else if (index == currentPageIndex + 1) {
      return Transform(
        alignment: rightPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(-rotationAngle * (1 - currentPageDelta)),
        child: page,
      );
    } else {
      return page;
    }
  }
}
