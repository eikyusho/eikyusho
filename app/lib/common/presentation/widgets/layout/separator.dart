import 'package:flutter/material.dart';

import 'package:core/core.dart';

abstract class Separator extends StatelessWidget {
  const Separator({this.size = double.maxFinite, super.key});

  const factory Separator.horizontal({required double size}) =
      HorizontalSeparator;

  const factory Separator.vertical({required double size}) = VerticalSeparator;

  const factory Separator.dot({double radius}) = DotSeparator;

  final double size;
}

@protected
class HorizontalSeparator extends Separator {
  const HorizontalSeparator({required super.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: 1,
      color: context.colors.border,
    );
  }
}

@protected
class VerticalSeparator extends Separator {
  const VerticalSeparator({required super.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: 1,
      color: context.colors.border,
    );
  }
}

@protected
class DotSeparator extends Separator {
  const DotSeparator({super.key, this.radius = 2});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: context.colors.textAuxiliary,
    );
  }
}
