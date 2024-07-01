import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    required this.icon,
    required this.label,
    this.fillIcon = false,
    this.placeholder,
    this.onTap,
    super.key,
  });

  final SvgGenImage icon;
  final bool fillIcon;
  final Text label;
  final String? placeholder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClickableElement(
      onTap: onTap,
      borderRadius: AppDimens.radiusLg,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface,
          boxShadow: context.shadows.sm,
        ),
        padding: const EdgeInsets.all(AppDimens.md),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: context.colors.surfaceSecondary,
              radius: 30,
              child: icon.svg(
                width: AppDimens.$4xl,
                height: AppDimens.$4xl,
                colorFilter: svgColor(context.colors.textAuxiliary),
              ),
            ),
            const HSpace(AppDimens.sm),
            label.textStyle(
              color: context.colors.textPrimary,
              context.textTheme.bodyLg.medium,
            ),
            const Spacer(),
            Row(
              children: [
                Text(placeholder ?? '').textStyle(
                  context.textTheme.bodyMd,
                  color: context.colors.textAuxiliary,
                ),
                Assets.icons.caretRightBold.svg(
                  colorFilter: svgColor(context.colors.textAuxiliary),
                  width: AppDimens.$2xl,
                  height: AppDimens.$2xl,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
