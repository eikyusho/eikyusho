part of 'widget.dart';

enum ClickableElementAnimation { none, overlay, grow, shrink }

@immutable
final class _Styles {
  const _Styles._();

  static const double initialScale = 1;

  static const animationDuration = AppMisc.fastDuration;

  static Color overlayColor(BuildContext context, {required bool isPressing}) {
    return isPressing
        ? context.colors.primary.withOpacity(0.1)
        : AppColors.transparent;
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
