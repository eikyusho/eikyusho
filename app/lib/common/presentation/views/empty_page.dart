import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    required this.image,
    required this.message,
    required this.description,
    this.tip,
    this.error,
    this.actionIcon,
    this.actionText,
    this.onAction,
    super.key,
  });

  final AssetGenImage image;
  final SvgGenImage? actionIcon;
  final String message;
  final String description;
  final String? tip;
  final Exception? error;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final hasTip = tip != null;
    final hasError = error != null;
    final hasAction = actionText != null && onAction != null;
    final padding = context.screenPadding;

    return SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.only(
          top: padding.top,
          bottom: padding.bottom,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            image.image(),
            const VSpace(AppDimens.xl),
            Text(capitalizeMessage(message)).textStyle(
              context.textTheme.titleMd.black,
              color: context.colors.textPrimary,
            ),
            const VSpace(AppDimens.xs),
            Text(description).textStyle(
              context.textTheme.bodySm.regular,
              color: context.colors.textSecondary,
              align: TextAlign.center,
            ),
            if (hasTip) ...[
              const Spacer(),
              buildInfo(context, Assets.icons.infoBold, tip!),
              const VSpace(AppDimens.$2xl),
            ],
            if (hasError) ...[
              const Spacer(),
              buildInfo(
                context,
                Assets.icons.warningCircleBold,
                error!.toString(),
              ),
              const VSpace(AppDimens.$2xl),
            ],
            if (hasAction) ...[
              if (!hasTip && !hasError) const Spacer(),
              ActionButton(
                icon: actionIcon,
                center: true,
                text: actionText!,
                onTap: onAction!,
              ).px(AppDimens.$2xl),
            ],
            const VSpace(AppDimens.xl),
            if (!hasAction && !hasTip && !hasError) const Spacer(),
          ],
        ),
      ),
    );
  }

  String capitalizeMessage(String text) {
    return text.split(' ').map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  Widget buildInfo(BuildContext context, SvgGenImage icon, String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon.svg(
          width: AppDimens.iconMd,
          height: AppDimens.iconMd,
          colorFilter: svgColor(context.colors.textSecondary),
        ),
        const HSpace(AppDimens.sm),
        Text(message).textStyle(
          context.textTheme.bodySm.regular,
          color: context.colors.textSecondary,
        ),
      ],
    );
  }
}
