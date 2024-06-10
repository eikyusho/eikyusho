import 'package:flutter/material.dart';

class ColorsThemeExtension extends ThemeExtension<ColorsThemeExtension> {
  const ColorsThemeExtension({
    required this.primary,
    required this.primaryVariant,
    required this.background,
    required this.backgroundSecondary,
    required this.backgroundAuxiliary,
    required this.surface,
    required this.surfaceSecondary,
    required this.surfaceAuxiliary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textAuxiliary,
    required this.textSubdued,
    required this.textButton,
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
    required this.border,
    required this.borderDiscreet,
    required this.borderInverse,
  });

  final Color primary;
  final Color primaryVariant;

  final Color background;
  final Color backgroundSecondary;
  final Color backgroundAuxiliary;

  final Color surface;
  final Color surfaceSecondary;
  final Color surfaceAuxiliary;

  final Color textPrimary;
  final Color textSecondary;
  final Color textAuxiliary;
  final Color textSubdued;
  final Color textButton;

  final Color error;
  final Color success;
  final Color warning;
  final Color info;

  final Color border;
  final Color borderDiscreet;
  final Color borderInverse;

  @override
  ThemeExtension<ColorsThemeExtension> copyWith({
    Color? primary,
    Color? primaryVariant,
    Color? background,
    Color? backgroundSecondary,
    Color? backgroundAuxiliary,
    Color? surface,
    Color? surfaceSecondary,
    Color? surfaceAuxiliary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textAuxiliary,
    Color? textSubdued,
    Color? textButton,
    Color? error,
    Color? success,
    Color? warning,
    Color? info,
    Color? border,
    Color? borderDiscreet,
    Color? borderInverse,
  }) {
    return ColorsThemeExtension(
      primary: primary ?? this.primary,
      primaryVariant: primaryVariant ?? this.primaryVariant,
      background: background ?? this.background,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundAuxiliary: backgroundAuxiliary ?? this.backgroundAuxiliary,
      surface: surface ?? this.surface,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceAuxiliary: surfaceAuxiliary ?? this.surfaceAuxiliary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textAuxiliary: textAuxiliary ?? this.textAuxiliary,
      textSubdued: textSubdued ?? this.textSubdued,
      textButton: textButton ?? this.textButton,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      border: border ?? this.border,
      borderDiscreet: borderDiscreet ?? this.borderDiscreet,
      borderInverse: borderInverse ?? this.borderInverse,
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
      backgroundSecondary:
          Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
      backgroundAuxiliary:
          Color.lerp(backgroundAuxiliary, other.backgroundAuxiliary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSecondary:
          Color.lerp(surfaceSecondary, other.surfaceSecondary, t)!,
      surfaceAuxiliary:
          Color.lerp(surfaceAuxiliary, other.surfaceAuxiliary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textAuxiliary: Color.lerp(textAuxiliary, other.textAuxiliary, t)!,
      textSubdued: Color.lerp(textSubdued, other.textSubdued, t)!,
      textButton: Color.lerp(textButton, other.textButton, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderDiscreet: Color.lerp(borderDiscreet, other.borderDiscreet, t)!,
      borderInverse: Color.lerp(borderInverse, other.borderInverse, t)!,
    );
  }
}
