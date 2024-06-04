import 'package:flutter/material.dart';

class ShadowsThemeExtension extends ThemeExtension<ShadowsThemeExtension> {
  const ShadowsThemeExtension({
    required this.shadowSm,
    required this.shadowMd,
    required this.shadowLg,
  });

  final List<BoxShadow> shadowSm;
  final List<BoxShadow> shadowMd;
  final List<BoxShadow> shadowLg;

  @override
  ThemeExtension<ShadowsThemeExtension> copyWith({
    List<BoxShadow>? shadowSm,
    List<BoxShadow>? shadowMd,
    List<BoxShadow>? shadowLg,
  }) {
    return ShadowsThemeExtension(
      shadowSm: shadowSm ?? this.shadowSm,
      shadowMd: shadowMd ?? this.shadowMd,
      shadowLg: shadowLg ?? this.shadowLg,
    );
  }

  @override
  ThemeExtension<ShadowsThemeExtension> lerp(
    covariant ThemeExtension<ShadowsThemeExtension>? other,
    double t,
  ) {
    if (other is! ShadowsThemeExtension) {
      return this;
    }
    return ShadowsThemeExtension(
      shadowSm: BoxShadow.lerpList(shadowSm, other.shadowSm, t)!,
      shadowMd: BoxShadow.lerpList(shadowMd, other.shadowMd, t)!,
      shadowLg: BoxShadow.lerpList(shadowLg, other.shadowLg, t)!,
    );
  }
}
