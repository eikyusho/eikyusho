import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class NovelDetails extends StatelessWidget {
  const NovelDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final tags = ['Antihero', 'Cheat', 'Fantasy', 'Game Elements', 'Magic']
        .map((tag) => '#${tag.toUpperCase()}')
        .toList()
        .limit(3);

    return Column(
      children: [
        const Text(
          'List with MC overpower with cheats: Immerse yourself in exciting '
          'stories of superpowered protagonists armed with cheats, a '
          'narrative setting that seamlessly combines fantasy and '
          'wish-fulfillment. The temptation lies in the pursuit of '
          'boundless power and the implications it has on their worlds.',
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ).textStyle(
          context.textTheme.bodySm.regular,
          color: context.colors.textSecondary,
        ),
        const VSpace(AppDimens.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tags.join(' ')).textStyle(
              context.textTheme.bodyXs.bold,
              color: context.colors.textAuxiliary,
            ),
            AppIconButton(
              Assets.icons.arrowDownBold,
              size: AppDimens.iconMd,
              iconSize: AppDimens.iconXs,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
