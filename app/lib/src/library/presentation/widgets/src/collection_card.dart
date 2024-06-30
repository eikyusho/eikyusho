import 'package:app/common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    const size = 90.0;
    const iconSize = 52.0;
    const title = 'The Best System Novels With An Overpower Main Character';
    final tags =
        ['ANTI-HERO', 'MC OVERPOWER', 'CHEATS'].map((tag) => '#$tag').toList();
    const description = 'List with mc overpower with cheats and system.';

    return Row(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            boxShadow: context.shadows.sm,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.stackBold.svg(
                width: iconSize,
                height: iconSize,
                colorFilter: svgColor(context.colors.primary),
              ),
            ],
          ),
        ),
        const HSpace(AppDimens.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(title, maxLines: 1).textStyle(
                context.textTheme.bodyMd.medium.apply(
                  overflow: TextOverflow.ellipsis,
                ),
                color: context.colors.textPrimary,
              ),
              const VSpace(AppDimens.xs),
              Text(tags.join(' '), maxLines: 1).textStyle(
                context.textTheme.bodyXs.bold.apply(
                  overflow: TextOverflow.ellipsis,
                ),
                color: context.colors.textAuxiliary,
              ),
              const VSpace(AppDimens.xs),
              Row(
                children: [
                  Assets.icons.booksFill.svg(
                    width: AppDimens.iconSm,
                    height: AppDimens.iconSm,
                    colorFilter: svgColor(context.colors.textSecondary),
                  ),
                  const HSpace(AppDimens.xs),
                  Text('${tags.length}'),
                  const HSpace(AppDimens.xs),
                  const Separator.dot(),
                  const HSpace(AppDimens.xs),
                  const Expanded(
                    child: Text(description, maxLines: 1),
                  ),
                ],
              ).textStyle(
                context.textTheme.bodySm.regular.apply(
                  overflow: TextOverflow.ellipsis,
                ),
                color: context.colors.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
