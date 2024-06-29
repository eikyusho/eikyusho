import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/presentation/cubits/cubits.dart';
import 'package:app/src/reader/presentation/widgets/src/chapter_tile.dart';

class NovelChapters extends StatelessWidget {
  const NovelChapters({required this.novel, super.key});

  final NovelDetails novel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
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
        ),
        const VSpace(AppDimens.xs),
        BlocBuilder<NovelCubit, NovelState>(
          builder: (context, state) {
            if (state is! NovelLoaded) {
              return const Loading();
            }

            return ValueListenableBuilder(
              valueListenable: context.read<NovelCubit>().isAscending,
              builder: (context, value, child) {
                return Column(
                  children: gapView(
                    AppDimens.md,
                    isVertical: true,
                    children: value
                        ? buildList(state)
                        : buildList(state).reversed.toList(),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  List<Widget> buildList(NovelLoaded state) {
    return [
      ...state.chapters.map((chapter) {
        return ChapterTile(
          chapter: chapter,
          chapters: state.chapters,
        );
      }),
      if (state.isLoading) ...[
        const VSpace(AppDimens.md),
        const Loading(),
      ],
    ];
  }
}
