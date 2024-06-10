import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../../enums/text_size.dart';
import '../extensions/colors_theme_extension.dart';
import '../extensions/shadows_theme_extension.dart';
import '../extensions/text_theme_extension.dart';
import 'colors.dart';

abstract base class BaseTheme {
  StyleCreator get style => StyleCreator(this);

  // * || Properties
  Brightness get brightness;

  String get fontFamily => FontFamily.gotham;

  // * || Extensions
  ColorsThemeExtension get colors;

  ShadowsThemeExtension get shadows;

  TextThemeExtension get text {
    return TextThemeExtension(
      bodyXs: style.textStyle(TextSize.xs),
      bodySm: style.textStyle(TextSize.sm),
      bodyMd: style.textStyle(TextSize.md),
      bodyLg: style.textStyle(TextSize.lg),
      titleSm: style.textStyle(TextSize.xl),
      titleMd: style.textStyle(TextSize.$2xl),
      titleLg: style.textStyle(TextSize.$3xl),
    );
  }

  // * || Theme
  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: fontFamily,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primary,
        primary: colors.primary,
        brightness: brightness,
      ),
      extensions: [
        colors,
        shadows,
        text,
      ],
    );
  }
}

/// * To create props for theme extensions
class StyleCreator {
  StyleCreator(this.theme);

  final BaseTheme theme;

  TextStyle textStyle(TextSize size) {
    return TextStyle(
      fontSize: size.value,
      height: size.height,
      fontFamily: theme.fontFamily, // ? Just for garanty
    );
  }

  BoxShadow shadow({
    required double opacity,
    required double blur,
    required double offsetDy,
    double offsetDx = 0.0,
    double spread = 0.0,
  }) {
    return BoxShadow(
      color: AppColors.black.withOpacity(opacity),
      offset: Offset(offsetDx, offsetDy),
      blurRadius: blur,
      spreadRadius: spread,
    );
  }
}

/// * To create a theme decoration for a widget
abstract base class WidgetStyle<T> {
  const WidgetStyle(this.theme);

  final BaseTheme theme;

  T get decorator;
}
