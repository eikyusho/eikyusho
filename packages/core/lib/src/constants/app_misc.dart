import 'dart:ui';

import '../theme/base/colors.dart';

final class AppMisc {
  const AppMisc._();

  // * || Time Constants
  /// Duration: 300ms
  static const Duration normalDuration = Duration(milliseconds: 300);

  /// Duration: 100ms
  static const Duration fastDuration = Duration(milliseconds: 100);

  // * || Theme Constants
  static const Color darkBg = AppColors.dark900;
  static const Color lightBg = AppColors.neutral50;

  // Blur filter
  static const double blurFilter = 13.33;

  // Blur bg opacity
  /// Opacity: 0.65
  static const double blurBgOpacity = 0.65;

  /// Opacity: 0.5
  static const double blurBgOpacityVariant = 0.5;

  /// BlendMode: srcIn
  static const BlendMode blendMode = BlendMode.srcIn;

  /// Novel title max lines
  static const int novelTitleMaxLines = 2;
}
