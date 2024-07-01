import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/buttons/button.dart';

enum DialogType {
  warning,
  danger,
  success,
  info;

  SvgGenImage get _icon {
    return switch (this) {
      info => Assets.icons.infoBold,
      success => Assets.icons.circleCheck,
      warning => Assets.icons.warningBold,
      danger => Assets.icons.warningBold,
    };
  }

  Color color(BuildContext context) {
    return switch (this) {
      info => context.colors.info,
      success => context.colors.success,
      warning => context.colors.warning,
      danger => context.colors.error,
    };
  }
}

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.type,
    required this.onConfirm,
    required this.title,
    required this.description,
    super.key,
  });

  final DialogType type;
  final VoidCallback onConfirm;
  final Text title;
  final Text description;

  @override
  Widget build(BuildContext context) {
    const iconSize = AppDimens.iconXl;

    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(
          top: AppDimens.xl,
          bottom: AppDimens.lg,
          left: AppDimens.lg,
          right: AppDimens.lg,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          color: context.colors.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: AppDimens.iconLg,
                  backgroundColor: context.colors.backgroundSecondary,
                  child: type._icon.svg(
                    width: iconSize,
                    height: iconSize,
                    colorFilter: svgColor(type.color(context)),
                  ),
                ),
                title.textStyle(
                  context.textTheme.bodyLg.medium,
                  color: context.colors.textSubdued,
                ),
              ],
            ).gap(AppDimens.sm),
            const VSpace(AppDimens.lg),
            description.textStyle(
              context.textTheme.bodyMd.regular,
              color: context.colors.textPrimary,
            ),
            const VSpace(AppDimens.lg),
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Button(
                    text: context.translate.button_cancel,
                    type: ButtonType.secondary,
                    onTap: () => Navigator.of(context).pop(),
                  ).expanded(),
                  Button(
                    text: context.translate.button_confirm,
                    onTap: () {
                      onConfirm();
                      Navigator.of(context).pop();
                    },
                  ).expanded(),
                ],
              ).gap(AppDimens.md),
            ),
          ],
        ),
      ),
    );
  }
}
