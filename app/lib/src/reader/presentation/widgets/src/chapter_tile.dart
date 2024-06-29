import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';

class ChapterTile extends StatelessWidget {
  const ChapterTile({required this.chapter, required this.chapters, super.key});

  final Chapter chapter;
  final List<Chapter> chapters;

  @override
  Widget build(BuildContext context) {
    return ClickableElement(
      borderRadius: AppDimens.radiusLg,
      onTap: () {
        context.router.push(
          ReaderRoute(chapter: chapter, chapters: chapters),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.md,
          vertical: AppDimens.sm,
        ),
        color: context.colors.surface,
        child: Row(
          children: [
            Text(chapter.number).textStyle(
              context.textTheme.bodyLg.regular,
              color: context.colors.textSecondary,
            ),
            const HSpace(AppDimens.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).textStyle(
                    context.textTheme.bodyMd.medium,
                    color: context.colors.textPrimary,
                  ),
                  const VSpace(AppDimens.xs),
                  Text(chapter.date).textStyle(
                    context.textTheme.bodyXs.regular,
                    color: context.colors.textAuxiliary,
                  ),
                ],
              ),
            ),
            const HSpace(AppDimens.sm),
            ProgressButton(
              idleIcon: Assets.icons.arrowDownBold,
              color: context.colors.surfaceSecondary,
              state: ProgressButtonState.idle,
              context: context,
              progress: 1,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
