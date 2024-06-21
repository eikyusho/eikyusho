import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class NovelChapters extends StatelessWidget {
  const NovelChapters({super.key});

  @override
  Widget build(BuildContext context) {
    const kTileHeight = 44.0;

    return Stack(
      children: [
        Positioned.fill(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: kTileHeight + AppDimens.xs),
            separatorBuilder: (context, index) => const VSpace(AppDimens.md),
            itemBuilder: (context, index) {
              return ChapterTile(
                number: index + 1,
                title: 'Chapter',
                date: '2021-01-${index + 1}',
              );
            },
            itemCount: 10,
          ),
        ),
        Container(
          height: kTileHeight,
          width: double.infinity,
          color: context.colors.background,
          padding: const EdgeInsets.symmetric(vertical: AppDimens.md),
          child: Text(AppStrings.sectionTitleChapters).textStyle(
            context.textTheme.bodyMd.medium,
            color: context.colors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    required this.number,
    required this.title,
    required this.date,
    super.key,
  });

  final int number;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.md,
        vertical: AppDimens.sm,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      child: Row(
        children: [
          Text('$number').textStyle(
            context.textTheme.bodyLg.regular,
            color: context.colors.textSecondary,
          ),
          const HSpace(AppDimens.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title).textStyle(
                context.textTheme.bodyMd.medium,
                color: context.colors.textPrimary,
              ),
              const VSpace(AppDimens.xs),
              Text(date).textStyle(
                context.textTheme.bodyXs.regular,
                color: context.colors.textAuxiliary,
              ),
            ],
          ),
          const Spacer(),
          ProgressButton(
            idleIcon: Assets.icons.arrowDownBold,
            color: context.colors.surfaceSecondary,
            state: ProgressButtonState.idle,
            context: context,
            progress: 1,
            onTap: () {},
            // size: AppDimens.buttonSm,
            // iconSize: AppDimens.iconMd,
            // onPressed: () {},
          ),
        ],
      ),
    );
  }
}
