import 'package:flutter/material.dart';

class ColorsThemeExtension extends ThemeExtension<ColorsThemeExtension> {
  const ColorsThemeExtension({
    required this.primary,
    required this.primaryVariant,
    required this.background,
    required this.backgroundVariant,
    required this.backgroundAuxiliary,
    required this.surface,
    required this.surfaceVariant,
    required this.surfaceAuxiliary,
    required this.primaryText,
    required this.secondaryText,
    required this.auxiliaryText,
    required this.subduedText,
    required this.buttonText,
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
    required this.vividBorder,
    required this.discreetBorder,
    required this.inverseBorder,
  });

  final Color primary;
  final Color primaryVariant;

  final Color background;
  final Color backgroundVariant;
  final Color backgroundAuxiliary;

  final Color surface;
  final Color surfaceVariant;
  final Color surfaceAuxiliary;

  final Color primaryText;
  final Color secondaryText;
  final Color auxiliaryText;
  final Color subduedText;
  final Color buttonText;

  final Color error;
  final Color success;
  final Color warning;
  final Color info;

  final Color vividBorder;
  final Color discreetBorder;
  final Color inverseBorder;

  @override
  ThemeExtension<ColorsThemeExtension> copyWith({
    Color? primary,
    Color? primaryVariant,
    Color? background,
    Color? backgroundVariant,
    Color? backgroundAuxiliary,
    Color? surface,
    Color? surfaceVariant,
    Color? surfaceAuxiliary,
    Color? primaryText,
    Color? secondaryText,
    Color? auxiliaryText,
    Color? subduedText,
    Color? buttonText,
    Color? error,
    Color? success,
    Color? warning,
    Color? info,
    Color? vividBorder,
    Color? discreetBorder,
    Color? inverseBorder,
  }) {
    return ColorsThemeExtension(
      primary: primary ?? this.primary,
      primaryVariant: this.primaryVariant,
      background: background ?? this.background,
      backgroundVariant: this.backgroundVariant,
      backgroundAuxiliary: this.backgroundAuxiliary,
      surface: this.surface,
      surfaceVariant: this.surfaceVariant,
      surfaceAuxiliary: this.surfaceAuxiliary,
      primaryText: this.primaryText,
      secondaryText: this.secondaryText,
      auxiliaryText: this.auxiliaryText,
      subduedText: this.subduedText,
      buttonText: this.buttonText,
      error: this.error,
      success: this.success,
      warning: this.warning,
      info: this.info,
      vividBorder: this.vividBorder,
      discreetBorder: this.discreetBorder,
      inverseBorder: this.inverseBorder,
    );
  }

  @override
  ThemeExtension<ColorsThemeExtension> lerp(
    covariant ThemeExtension<ColorsThemeExtension>? other,
    double t,
  ) {
    if (other is! ColorsThemeExtension) {
      return this;
    }

    return ColorsThemeExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryVariant: Color.lerp(primaryVariant, other.primaryVariant, t)!,
      background: Color.lerp(background, other.background, t)!,
      backgroundVariant:
          Color.lerp(backgroundVariant, other.backgroundVariant, t)!,
      backgroundAuxiliary:
          Color.lerp(backgroundAuxiliary, other.backgroundAuxiliary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      surfaceAuxiliary:
          Color.lerp(surfaceAuxiliary, other.surfaceAuxiliary, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      auxiliaryText: Color.lerp(auxiliaryText, other.auxiliaryText, t)!,
      subduedText: Color.lerp(subduedText, other.subduedText, t)!,
      buttonText: Color.lerp(buttonText, other.buttonText, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      vividBorder: Color.lerp(vividBorder, other.vividBorder, t)!,
      discreetBorder: Color.lerp(discreetBorder, other.discreetBorder, t)!,
      inverseBorder: Color.lerp(inverseBorder, other.inverseBorder, t)!,
    );
  }
}
