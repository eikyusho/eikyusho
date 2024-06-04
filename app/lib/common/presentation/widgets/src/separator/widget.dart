import 'package:flutter/cupertino.dart';

class Separator extends StatelessWidget {
  const Separator.horizontal({required this.space, super.key});

  const Separator.vertical({required this.space, super.key});

  final double space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space,
      width: space,
    );
  }
}
