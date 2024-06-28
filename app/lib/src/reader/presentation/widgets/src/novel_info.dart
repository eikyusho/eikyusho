import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class NovelInfo extends StatelessWidget {
  const NovelInfo({required this.details, super.key});

  final NovelDetails details;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          width: context.responsiveWidth(
            0.25,
            absoluteWidth: 123,
          ),
          height: context.responsiveHeight(
            0.25,
            absoluteHeight: 164,
          ),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
          ),
          child: Image(
            image: ResizeImage(
              NetworkImage(details.cover),
              width: 123,
              height: 164,
            ),
            fit: BoxFit.cover,
          ),
        ),
        const HSpace(AppDimens.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                details.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ).textStyle(
                context.textTheme.bodyLg.bold,
                color: context.colors.textPrimary,
              ),
              const VSpace(AppDimens.sm),
              Text(details.author).textStyle(
                context.textTheme.bodyMd.medium,
                color: context.colors.textAuxiliary,
              ),
              const VSpace(AppDimens.sm),
              Row(
                children: [
                  Text(details.source.name),
                  Separator.dot(
                    color: context.colors.primary,
                  ),
                  Text(details.source.language.toUpperCase()),
                  Assets.icons.caretRightBold.svg(
                    height: AppDimens.iconXs,
                    width: AppDimens.iconXs,
                    colorFilter: svgColor(context.colors.primary),
                  ),
                ],
              ).gap(AppDimens.xs).textStyle(
                    context.textTheme.bodyXs.medium,
                    color: context.colors.primary,
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
