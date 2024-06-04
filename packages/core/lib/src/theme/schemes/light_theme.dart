import 'package:flutter/material.dart';

import '../../constants/app_misc.dart';
import '../base/base_theme.dart';
import '../base/colors.dart';
import '../extensions/colors_theme_extension.dart';
import '../extensions/shadows_theme_extension.dart';

final class LightTheme extends BaseTheme {
  @override
  Brightness get brightness => Brightness.light;

  @override
  ColorsThemeExtension get colors {
    return const ColorsThemeExtension(
      primary: AppColors.primary500,
      primaryVariant: AppColors.primary700,
      background: AppMisc.lightBg,
      backgroundSecondary: AppColors.neutral200,
      backgroundAuxiliary: AppColors.neutral600,
      surface: AppColors.neutral100,
      surfaceSecondary: AppColors.neutral300,
      surfaceAuxiliary: AppColors.neutral500,
      textPrimary: AppColors.dark900,
      textSecondary: AppColors.dark600,
      textAuxiliary: AppColors.dark400,
      textSubdued: AppColors.dark100,
      textButton: AppColors.neutral100,
      error: AppColors.danger500,
      success: AppColors.success700,
      warning: AppColors.warning600,
      info: AppColors.info600,
      border: AppColors.neutral300,
      borderDiscreet: AppColors.neutral200,
      borderInverse: AppColors.dark50,
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
        style.shadow(opacity: 0.06, blur: 4, offsetDy: 2, spread: -2),
        style.shadow(opacity: 0.1, blur: 8, offsetDy: 4, spread: -2),
      ],
      shadowLg: [
        style.shadow(opacity: 0.25, blur: 48, offsetDy: 24, spread: -12),
      ],
    );
  }
}
