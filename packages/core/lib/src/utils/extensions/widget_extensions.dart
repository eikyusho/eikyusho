import 'package:flutter/material.dart';

import '../helpers/layout.dart';

extension TextStyleExtension on Widget {
  Widget textStyle(TextStyle style, {required Color color, TextAlign? align}) {
    return DefaultTextStyle.merge(
      style: style.apply(color: color),
      textAlign: align,
      child: this,
    );
  }
}

extension ExpandedExtension on Widget {
  Expanded expanded([int flex = 1]) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }
}

extension VGapExtension on Column {
  Column gap(double gap) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: gapView(gap, children: children, isVertical: true),
    );
  }
}

extension HGapExtension on Row {
  Row gap(double gap) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: gapView(gap, children: children),
    );
  }
}

extension PaddingExtension on Widget {
  /// Add padding to all sides of the widget
  Padding pAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  /// Add horizontal padding to the widget
  Padding px(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: this,
    );
  }

  /// Add vertical padding to the widget
  Padding py(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: this,
    );
  }

  /// Add top padding to the widget
  Padding pt(double padding) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: this,
    );
  }

  /// Add bottom padding to the widget
  Padding pb(double padding) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: this,
    );
  }

  /// Add right padding to the widget
  Padding pr(double padding) {
    return Padding(
      padding: EdgeInsets.only(right: padding),
      child: this,
    );
  }

  /// Add left padding to the widget
  Padding pl(double padding) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: this,
    );
  }
}

extension GestureOnEmptySpace on Widget {
  /// to detect gestures on the whole container
  Widget empty() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: this,
    );
  }
}
