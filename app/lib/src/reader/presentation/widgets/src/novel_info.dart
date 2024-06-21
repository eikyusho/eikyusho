import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class NovelInfo extends StatelessWidget {
  const NovelInfo({
    required this.title,
    required this.cover,
    required this.author,
    required this.source,
    required this.language,
    super.key,
  });

  final String title;
  final String cover;
  final String author;
  final String source;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          width: context.responsiveWidth(
            0.25,
            absoluteWidth: 123,
            biggest: true,
          ),
          height: context.responsiveHeight(
            0.25,
            absoluteHeight: 164,
            biggest: true,
          ),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
          ),
          child: Image(
            image: ResizeImage(
              NetworkImage(cover),
              width: 123,
              height: 164,
            ),
            fit: BoxFit.cover,
          ),
        ),
        const HSpace(AppDimens.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title).textStyle(
              context.textTheme.bodyLg.bold,
              color: context.colors.textPrimary,
            ),
            const VSpace(AppDimens.sm),
            Text(author).textStyle(
              context.textTheme.bodyMd.medium,
              color: context.colors.textAuxiliary,
            ),
            const VSpace(AppDimens.sm),
            Row(
              children: [
                Text(source),
                Separator.dot(
                  color: context.colors.primary,
                ),
                Text(language.toUpperCase()),
                Assets.icons.caretRightBold.svg(
                  height: AppDimens.iconXs,
                  width: AppDimens.iconXs,
                  colorFilter: ColorFilter.mode(
                    context.colors.primary,
                    AppMisc.blendMode,
                  ),
                ),
              ],
            ).gap(AppDimens.xs).textStyle(
                  context.textTheme.bodyXs.medium,
                  color: context.colors.primary,
                ),
          ],
        ),
      ],
    );
  }
}
