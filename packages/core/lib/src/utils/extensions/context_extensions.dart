import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import './class_extensions.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  bool get isDarkTheme => theme.brightness == Brightness.dark;

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
