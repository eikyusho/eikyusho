import 'package:flutter/material.dart';

import '../../../core.dart';
import '../base/base_theme.dart';
import '../extensions/colors_theme_extension.dart';
import '../extensions/shadows_theme_extension.dart';

final class DarkTheme extends BaseTheme {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  ColorsThemeExtension get colors {
    return const ColorsThemeExtension(
      primary: AppColors.primary500,
      primaryVariant: AppColors.primary700,
      background: AppMisc.darkBg,
      backgroundSecondary: AppColors.dark600,
      backgroundAuxiliary: AppColors.neutral900,
      surface: AppColors.dark800,
      surfaceSecondary: AppColors.dark200,
      surfaceAuxiliary: AppColors.dark400,
      textPrimary: AppColors.neutral50,
      textSecondary: AppColors.neutral300,
      textAuxiliary: AppColors.neutral600,
      textSubdued: AppColors.neutral100,
      textButton: AppColors.neutral100,
      error: AppColors.danger500,
      success: AppColors.success800,
      warning: AppColors.warning600,
      info: AppColors.info600,
      border: AppColors.dark300,
      borderDiscreet: AppColors.dark800,
      borderInverse: AppColors.neutral400,
    );
  }

  @override
  ShadowsThemeExtension get shadows {
    return ShadowsThemeExtension(
      shadowSm: [
        style.shadow(opacity: 0.1, blur: 3, offsetDy: 1),
        style.shadow(opacity: 0.2, blur: 2, offsetDy: 1),
      ],
      shadowMd: [
        style.shadow(opacity: 0.1, blur: 4, offsetDy: 2, spread: -2),
        style.shadow(opacity: 0.2, blur: 8, offsetDy: 4, spread: -2),
      ],
      shadowLg: [
        style.shadow(opacity: 0.25, blur: 48, offsetDy: 24, spread: -12),
      ],
    );
  }
}
