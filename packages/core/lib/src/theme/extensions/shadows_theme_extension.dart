import 'package:flutter/material.dart';

class ShadowsThemeExtension extends ThemeExtension<ShadowsThemeExtension> {
  const ShadowsThemeExtension({
    required this.sm,
    required this.md,
    required this.lg,
  });

  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;

  @override
  ThemeExtension<ShadowsThemeExtension> copyWith({
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
  }) {
    return ShadowsThemeExtension(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
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
      sm: BoxShadow.lerpList(sm, other.sm, t)!,
      md: BoxShadow.lerpList(md, other.md, t)!,
      lg: BoxShadow.lerpList(lg, other.lg, t)!,
    );
  }
}
