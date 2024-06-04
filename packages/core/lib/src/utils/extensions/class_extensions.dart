import 'package:flutter/material.dart';

extension TextWeightExtension on TextStyle {
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get black => copyWith(fontWeight: FontWeight.w900);
}

extension EdgeInsetsExtension on EdgeInsets {
  EdgeInsets all(double value) {
    return EdgeInsets.all(value);
  }

  EdgeInsets px(double value) {
    return copyWith(left: value, right: value);
  }

  EdgeInsets py(double value) {
    return copyWith(top: value, bottom: value);
  }

  EdgeInsets pt(double value) {
    return copyWith(top: value);
  }

  EdgeInsets pb(double value) {
    return copyWith(bottom: value);
  }

  EdgeInsets pl(double value) {
    return copyWith(left: value);
  }

  EdgeInsets pr(double value) {
    return copyWith(right: value);
  }
}

extension OrExtension<T> on T? {
  T or(T alternative) {
    return this ?? alternative;
  }
}
