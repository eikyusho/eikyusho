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
    this.actionText,
    this.onAction,
    super.key,
  });

  final AssetGenImage image;
  final String message;
  final String description;
  final String? tip;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final hasTip = tip != null;
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
            ),
            if (hasAction) ...[
              const Spacer(),
              ActionButton(
                icon: null,
                center: true,
                text: actionText!,
                onTap: onAction!,
              ).px(AppDimens.$2xl),
            ],
            const VSpace(AppDimens.xl),
            if (hasTip) ...[
              const Spacer(),
              Text(description).textStyle(
                context.textTheme.bodySm.regular,
                color: context.colors.textSecondary,
              ),
            ],
            if (actionText == null) const Spacer(),
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
}
