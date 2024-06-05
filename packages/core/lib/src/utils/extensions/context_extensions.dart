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
  double get screenHeight => mediaQuery.size.height;

  double get screenWidth => mediaQuery.size.width;

  EdgeInsets get screenPadding => mediaQuery.padding;

  EdgeInsets get screenPaddingWithAppBar {
    final padding = mediaQuery.padding;
    return padding.copyWith(top: padding.top + AppDimens.appBarHeight);
  }

  double responsiveHeight(double relativeHeight, {double? absoluteHeight}) {
    final height = screenHeight * relativeHeight;

    if (absoluteHeight != null) {
      return height.clamp(0, absoluteHeight);
    }

    return height;
  }

  double responsiveWidth(double relativeWidth, {double? absoluteWidth}) {
    final width = screenWidth * relativeWidth;

    if (absoluteWidth != null) {
      return width.clamp(0, absoluteWidth);
    }

    return width;
  }

  bool get isTablet => screenWidth > 600;
}
