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

  /// BlendMode: srcIn
  static const BlendMode blendMode = BlendMode.srcIn;
}
