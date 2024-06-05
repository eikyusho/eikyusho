import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../clickable_element/widget.dart';

part 'styles.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton(
    this.icon, {
    this.onPressed,
    this.color,
    this.size,
    this.iconSize,
    this.iconColor,
    super.key,
  });
  final SvgGenImage icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? iconColor;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return ClickableElement(
      onTap: onPressed,
      borderRadius: _Styles.borderRadius,
      child: Container(
        color: color.getOr(_Styles.backgroundColor(context)),
        width: size.getOr(_Styles.width),
        height: size.getOr(_Styles.height),
        alignment: _Styles.alignment,
        child: icon.svg(
          width: iconSize.getOr(_Styles.iconSize),
          height: iconSize.getOr(_Styles.iconSize),
          colorFilter: ColorFilter.mode(
            iconColor.getOr(_Styles.iconColor(context)),
            _Styles.blendMode,
          ),
        ),
      ),
    );
  }
}
