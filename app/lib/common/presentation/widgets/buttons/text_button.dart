import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class ActionTextButton extends StatelessWidget {
  const ActionTextButton({
    required this.icon,
    required this.text,
    required this.onTap,
    this.color,
    super.key,
  });

  final SvgGenImage? icon;
  final Color? color;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClickableElement(
      onTap: onTap,
      borderRadius: AppDimens.radiusLg,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimens.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              icon!.svg(
                colorFilter: svgColor(color ?? context.colors.textAuxiliary),
                height: AppDimens.iconLg,
                width: AppDimens.iconLg,
              ),
            Text(text).textStyle(
              context.textTheme.bodyLg.medium,
              color: color ?? context.colors.textAuxiliary,
            ),
          ],
        ).gap(AppDimens.sm),
      ),
    );
  }
}
