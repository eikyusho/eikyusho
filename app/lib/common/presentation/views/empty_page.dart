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
    this.child,
    super.key,
  });

  final AssetGenImage image;
  final SvgGenImage? actionIcon;
  final String message;
  final String description;
  final String? tip;
  final Exception? error;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final hasTip = tip != null;
    final hasError = error != null;
    final hasChild = child != null;
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
              InfoMessage(
                icon: Assets.icons.infoBold,
                message: tip!,
              ),
              const VSpace(AppDimens.$2xl),
            ],
            if (hasError) ...[
              const Spacer(),
              InfoMessage(
                icon: Assets.icons.warningCircleBold,
                message: error!.toString(),
              ),
              const VSpace(AppDimens.$2xl),
            ],
            if (hasChild) ...[
              if (!hasTip && !hasError) const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.$2xl,
                ),
                child: child,
              ),
            ],
            const VSpace(AppDimens.xl),
            if (!hasChild && !hasTip && !hasError) const Spacer(),
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
