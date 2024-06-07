import 'package:flutter/material.dart';

import 'package:core/core.dart';

enum ClickableElementAnimation { none, overlay, grow, shrink }

@immutable
final class _Styles {
  const _Styles._();

  static const double initialScale = 1;

  static const animationDuration = AppMisc.fastDuration;
}

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
                        color: animationNotifier.isPressing
                            ? context.colors.primary.withOpacity(0.1)
                            : AppColors.transparent,
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

class _AnimationValueNotifier extends ChangeNotifier {
  double scale = _Styles.initialScale;
  bool isPressing = false;

  void animate(ClickableElementAnimation animation) {
    isPressing = true;
    scale = switch (animation) {
      ClickableElementAnimation.grow => 1.05,
      ClickableElementAnimation.shrink => 0.95,
      _ => _Styles.initialScale,
    };
    notifyListeners();
  }

  void reset() {
    isPressing = false;
    scale = _Styles.initialScale;
    notifyListeners();
  }
}
