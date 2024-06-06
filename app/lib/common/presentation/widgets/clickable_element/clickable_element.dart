import 'package:flutter/material.dart';

import 'package:core/core.dart';

part 'clickable_element.styles.dart';

class ClickableElement extends StatelessWidget {
  const ClickableElement({
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.borderRadius = AppDimens.none,
    this.animation = ClickableElementAnimation.overlay,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final double borderRadius;
  final ClickableElementAnimation animation;

  @override
  Widget build(BuildContext context) {
    final animationNotifier = _AnimationValueNotifier();

    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapDown: (details) => animationNotifier.animate(animation),
      onTapUp: (details) => animationNotifier.reset(),
      onTapCancel: animationNotifier.reset,
      child: ListenableBuilder(
        listenable: animationNotifier,
        builder: (context, child) {
          return AnimatedScale(
            duration: _Styles.animationDuration,
            scale: animationNotifier.scale,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Stack(
                children: [
                  child!,
                  if (animation == ClickableElementAnimation.overlay)
                    Positioned.fill(
                      child: AnimatedContainer(
                        duration: _Styles.animationDuration,
                        color: _Styles.overlayColor(
                          context,
                          isPressing: animationNotifier.isPressing,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        child: child,
      ),
    );
  }
}
