import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/interactions/clickable_element.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton(
    this.icon, {
    this.onPressed,
    this.color,
    this.size = AppDimens.buttonMd,
    this.iconSize = AppDimens.iconMd,
    this.iconColor,
    this.child,
    super.key,
  });

  final SvgGenImage icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? iconColor;
  final double size;
  final double iconSize;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClickableElement(
      onTap: onPressed,
      borderRadius: AppDimens.radiusMd,
      child: Container(
        color: color.getOr(context.colors.surface),
        width: size,
        height: size,
        alignment: Alignment.center,
        child: child != null
            ? child!
            : icon.svg(
                width: iconSize,
                height: iconSize,
                colorFilter: svgColor(
                  iconColor.getOr(context.colors.textPrimary),
                ),
              ),
      ),
    );
  }
}
