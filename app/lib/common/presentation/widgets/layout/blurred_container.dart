import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:core/core.dart';

class BlurredContainer extends StatelessWidget {
  const BlurredContainer({required this.blur, required this.child, super.key});

  final double blur;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }
}

Color getBlurredBgColor(BuildContext context, {Color? color, double? opacity}) {
  if (color != null) {
    return color.withOpacity(opacity ?? AppMisc.blurBgOpacity);
  }

  return context.colors.background.withOpacity(
    opacity ?? AppMisc.blurBgOpacity,
  );
}
