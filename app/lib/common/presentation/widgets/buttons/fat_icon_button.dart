import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class FatIconButton extends StatelessWidget {
  const FatIconButton({
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
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimens.sm),
        decoration: BoxDecoration(
          color: context.colors.surface,
          boxShadow: context.shadows.sm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              icon!.svg(
                colorFilter: svgColor(color ?? context.colors.textPrimary),
                height: AppDimens.iconXl,
                width: AppDimens.iconXl,
              ),
            Text(text).textStyle(
              context.textTheme.bodyLg.medium,
              color: color ?? context.colors.textPrimary,
            ),
          ],
        ).gap(AppDimens.xs),
      ),
    );
  }
}
