import 'package:flutter/material.dart';

import 'package:core/core.dart';

import 'package:app/common/common.dart';

class NovelStats extends StatelessWidget {
  const NovelStats({
    required this.status,
    required this.chapterCount,
    required this.viewCount,
    super.key,
  });

  final int chapterCount;
  final NovelStatus status;
  final String viewCount;

  @override
  Widget build(BuildContext context) {
    const separator = 36.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _NovelStat(label: AppStrings.labelChapters, value: '$chapterCount'),
        const Separator.vertical(size: separator),
        _NovelStat(label: AppStrings.labelStatus, value: status.name),
        const Separator.vertical(size: separator),
        _NovelStat(
          label: AppStrings.labelViews,
          value: viewCount,
        ),
      ],
    ).gap(AppDimens.md);
  }
}

class _NovelStat extends StatelessWidget {
  const _NovelStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value).textStyle(
            context.textTheme.bodyMd.bold,
            color: context.colors.primary,
          ),
          const VSpace(AppDimens.xs),
          Text(label).textStyle(
            context.textTheme.bodyXs.medium,
            color: context.colors.textAuxiliary,
          ),
        ],
      ),
    );
  }
}
