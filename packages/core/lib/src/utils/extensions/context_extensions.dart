import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/app_dimens.dart';
import '../../theme/theme.dart';
import './class_extensions.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  bool get isDarkTheme => theme.brightness == Brightness.dark;

  bool get isSystemDarkMode => mediaQuery.platformBrightness == Brightness.dark;

  // Temporary fix for the theme issue
  ThemeMode get themeMode => ThemeMode.system;

  BaseTheme get appTheme => AppTheme.selected(theme.brightness);

  ColorsThemeExtension get colors {
    return theme.extension<ColorsThemeExtension>().getOr(appTheme.colors);
  }

  TextThemeExtension get textTheme {
    return theme.extension<TextThemeExtension>().getOr(appTheme.text);
  }

  ShadowsThemeExtension get shadows {
    return theme.extension<ShadowsThemeExtension>().getOr(appTheme.shadows);
  }
}

extension MediaQueryExtension on BuildContext {
  bool get isAndroid => theme.platform == TargetPlatform.android;

  double get screenHeight => mediaQuery.size.height;

  double get screenWidth => mediaQuery.size.width;

  EdgeInsets get screenPadding => mediaQuery.padding;

  EdgeInsets get screenPaddingWithAppBar {
    final padding = mediaQuery.padding;
    return padding.copyWith(top: padding.top + AppDimens.appBarHeight);
  }

  double responsiveHeight(
    double relativeHeight, {
    double? absoluteHeight,
  }) {
    return _responsiveSize(
      biggest: isTablet,
      screenSize: screenHeight,
      relativeSize: relativeHeight,
      absoluteSize: absoluteHeight,
    );
  }

  double responsiveWidth(
    double relativeWidth, {
    double? absoluteWidth,
    bool biggest = false,
  }) {
    return _responsiveSize(
      biggest: isTablet,
      screenSize: screenWidth,
      relativeSize: relativeWidth,
      absoluteSize: absoluteWidth,
    );
  }

  double _responsiveSize({
    required double relativeSize,
    required double screenSize,
    required bool biggest,
    double? absoluteSize,
  }) {
    final size = screenSize * relativeSize;

    if (absoluteSize != null) {
      if (biggest) return max(size, absoluteSize);

      return size.clamp(0, absoluteSize);
    }

    return size;
  }

  bool get isTablet => screenWidth > 600;
}

extension SnackBarExtension on BuildContext {
  void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}

extension BottomSheetExtension on BuildContext {
  Future<void> showBottomSheet(
    Widget child, {
    double? height,
    bool isDismissable = true,
  }) async {
    await showModalBottomSheet<void>(
      context: this,
      isScrollControlled: true,
      isDismissible: isDismissable,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
      ),
      barrierColor: AppColors.black.withOpacity(.65),
      constraints: BoxConstraints(
        maxHeight: height ?? responsiveHeight(.9),
      ),
      builder: (_) => child,
    );
  }
}

extension DialogExtension on BuildContext {
  Future<void> showAppDialog(
    Widget child, {
    bool barrierDismissible = true,
  }) async {
    await showDialog<void>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (_) => child,
    );
  }
}
