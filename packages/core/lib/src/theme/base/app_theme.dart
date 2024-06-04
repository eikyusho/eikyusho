import 'package:flutter/material.dart';

import '../schemes/dark_theme.dart';
import '../schemes/light_theme.dart';
import 'base_theme.dart';

final _darkTheme = DarkTheme();
final _lightTheme = LightTheme();

class AppTheme {
  const AppTheme();

  static ThemeData dark() {
    return _darkTheme.themeData;
  }

  static ThemeData light() {
    return _lightTheme.themeData;
  }

  static BaseTheme selected(Brightness brightness) {
    return switch (brightness) {
      Brightness.dark => _darkTheme,
      Brightness.light => _lightTheme,
    };
  }
}
