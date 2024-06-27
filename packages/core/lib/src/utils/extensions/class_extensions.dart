import 'package:flutter/material.dart';

extension TextWeightExtension on TextStyle {
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get black => copyWith(fontWeight: FontWeight.w900);
}

extension AlternativeExtension<T> on T? {
  T getOr(T alternative) {
    return this ?? alternative;
  }
}
