import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/clickable_element.dart';

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
      borderRadius: AppDimens.radiusMd,
      child: Container(
        color: color.getOr(context.colors.surface),
        width: size.getOr(AppDimens.buttonMd),
        height: size.getOr(AppDimens.buttonMd),
        alignment: Alignment.center,
        child: icon.svg(
          width: iconSize.getOr(AppDimens.iconMd),
          height: iconSize.getOr(AppDimens.iconMd),
          colorFilter: ColorFilter.mode(
            iconColor.getOr(context.colors.textPrimary),
            AppMisc.blendMode,
          ),
        ),
      ),
    );
  }
}
