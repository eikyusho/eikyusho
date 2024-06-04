import 'package:flutter/material.dart';

class TextThemeExtension extends ThemeExtension<TextThemeExtension> {
  const TextThemeExtension({
    required this.bodyXs,
    required this.bodySm,
    required this.bodyMd,
    required this.bodyLg,
    required this.titleSm,
    required this.titleMd,
    required this.titleLg,
  });

  final TextStyle bodyXs;

  final TextStyle bodySm;

  final TextStyle bodyMd;

  final TextStyle bodyLg;

  final TextStyle titleSm;

  final TextStyle titleMd;

  final TextStyle titleLg;

  @override
  ThemeExtension<TextThemeExtension> copyWith({
    TextStyle? bodyXs,
    TextStyle? bodySm,
    TextStyle? bodyMd,
    TextStyle? bodyLg,
    TextStyle? titleSm,
    TextStyle? titleMd,
    TextStyle? titleLg,
  }) {
    return TextThemeExtension(
      bodyXs: bodyXs ?? this.bodyXs,
      bodySm: bodySm ?? this.bodySm,
      bodyMd: bodyMd ?? this.bodyMd,
      bodyLg: bodyLg ?? this.bodyLg,
      titleSm: titleSm ?? this.titleSm,
      titleMd: titleMd ?? this.titleMd,
      titleLg: titleLg ?? this.titleLg,
    );
  }

  @override
  ThemeExtension<TextThemeExtension> lerp(
    covariant ThemeExtension<TextThemeExtension>? other,
    double t,
  ) {
    if (other is! TextThemeExtension) {
      return this;
    }

    return TextThemeExtension(
      bodyXs: TextStyle.lerp(bodyXs, other.bodyXs, t)!,
      bodySm: TextStyle.lerp(bodySm, other.bodySm, t)!,
      bodyMd: TextStyle.lerp(bodyMd, other.bodyMd, t)!,
      bodyLg: TextStyle.lerp(bodyLg, other.bodyLg, t)!,
      titleSm: TextStyle.lerp(titleSm, other.titleSm, t)!,
      titleMd: TextStyle.lerp(titleMd, other.titleMd, t)!,
      titleLg: TextStyle.lerp(titleLg, other.titleLg, t)!,
    );
  }
}
