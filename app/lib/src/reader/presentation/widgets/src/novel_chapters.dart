import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/presentation/cubits/cubits.dart';
import 'package:app/src/reader/presentation/widgets/src/chapter_tile.dart';

class NovelChapterHeader extends StatelessWidget {
  const NovelChapterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.sectionTitleChapters).textStyle(
            context.textTheme.bodyMd.medium,
            color: context.colors.textPrimary,
          ),
          ValueListenableBuilder(
            valueListenable: context.read<NovelCubit>().isAscending,
            builder: (context, value, child) {
              return AppIconButton(
                value
                    ? Assets.icons.sortAscendingBold
                    : Assets.icons.sortDescendingBold,
                color: context.colors.background,
                onPressed: context.read<NovelCubit>().toggleSort,
              );
            },
          ),
        ],
      ),
    );
  }
}

class NovelChaptersList extends StatelessWidget {
  const NovelChaptersList({required this.chapters, super.key});

  final List<Chapter> chapters;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.read<NovelCubit>().isAscending,
      builder: (context, value, child) {
        final chapters =
            value ? this.chapters : this.chapters.reversed.toList();

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final chapter = chapters[index];
              final isLast = index == chapters.length - 1;

              return ChapterTile(
                chapter: chapter,
                chapters: chapters,
                isLast: isLast,
              );
            },
            childCount: chapters.length,
          ),
        );
      },
    );
  }
}
