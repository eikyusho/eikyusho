import 'package:flutter/cupertino.dart';

import 'package:app/src/browse/data/data.dart';

enum ExtensionCardType { available, installed, update }

class ExtensionCard extends StatelessWidget {
  const ExtensionCard({required this.type, super.key, this.extension});

  final ExtensionCardType type;
  final Extension? extension;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
