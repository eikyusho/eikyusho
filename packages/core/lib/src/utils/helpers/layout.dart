import 'package:flutter/material.dart';

import '../../../core.dart';

class VSpace extends StatelessWidget {
  const VSpace(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HSpace extends StatelessWidget {
  const HSpace(this.width, {super.key});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
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
