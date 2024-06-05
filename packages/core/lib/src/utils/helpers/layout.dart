import 'package:flutter/material.dart';

import '../../../core.dart';

class VSpace extends StatelessWidget {
  const VSpace(this.height, {super.key, this.factor = 1});

  final double height;
  final double factor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height * factor);
  }
}

class HSpace extends StatelessWidget {
  const HSpace(this.width, {super.key, this.factor = 1});

  final double width;
  final double factor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width * factor);
  }
}

List<Widget> gapView(
  double gap, {
  required Iterable<Widget> children,
  bool isVertical = false,
}) {
  return children.expand((child) sync* {
    if (child != children.first && children.length > 1) {
      yield isVertical ? SizedBox(height: gap) : SizedBox(width: gap);
    }
    yield child;
  }).toList();
}

BorderRadius borderRadius(double radius) {
  return BorderRadius.circular(radius);
}

ColorFilter svgColor(Color color) {
  return ColorFilter.mode(color, AppMisc.blendMode);
}
