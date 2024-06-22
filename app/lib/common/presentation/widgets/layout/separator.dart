import 'package:flutter/material.dart';

import 'package:core/core.dart';

abstract class Separator extends StatelessWidget {
  const Separator({this.size = double.maxFinite, super.key, this.color});

  const factory Separator.horizontal({required double size, Color color}) =
      HorizontalSeparator;

  const factory Separator.vertical({required double size, Color color}) =
      VerticalSeparator;

  const factory Separator.dot({double radius, Color color}) = DotSeparator;

  final double size;
  final Color? color;
}

@protected
class HorizontalSeparator extends Separator {
  const HorizontalSeparator({required super.size, super.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: 1,
      color: color ?? context.colors.border,
    );
  }
}

@protected
class VerticalSeparator extends Separator {
  const VerticalSeparator({required super.size, super.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: 1,
      color: color ?? context.colors.border,
    );
  }
}

@protected
class DotSeparator extends Separator {
  const DotSeparator({super.key, this.radius = 2, super.color});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color ?? context.colors.textAuxiliary,
    );
  }
}
