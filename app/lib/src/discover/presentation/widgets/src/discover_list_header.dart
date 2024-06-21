import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class DiscoverListHeader extends StatelessWidget {
  const DiscoverListHeader({required this.title, super.key});

  final Text title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title.textStyle(
          context.textTheme.titleSm.bold,
          color: context.colors.textPrimary,
        ),
        AppIconButton(
          Assets.icons.caretRightBold,
          iconColor: context.colors.primary,
          onPressed: () {},
        ),
      ],
    ).px(AppDimens.defaultHorizontalPadding).pb(AppDimens.lg);
  }
}
