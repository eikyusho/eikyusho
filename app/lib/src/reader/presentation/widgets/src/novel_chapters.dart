import 'package:app/src/reader/presentation/cubits/cubits.dart';
import 'package:app/src/reader/presentation/cubits/cubits.dart';
import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';

class NovelChapters extends StatelessWidget {
  const NovelChapters({super.key});

  @override
  Widget build(BuildContext context) {
    final isAscending = ValueNotifier<bool>(true);
    final state = context.read<NovelCubit>().state;

    final novel = switch (state) {
      NovelInfoLoaded() => state.novel,
      NovelChaptersLoaded() => state.novel,
      _ => null,
    };

    return Column(
      children: [
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(vertical: AppDimens.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.sectionTitleChapters).textStyle(
                context.textTheme.bodyMd.medium,
                color: context.colors.textPrimary,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: isAscending,
                builder: (context, ascending, child) {
                  return AppIconButton(
                    ascending
                        ? Assets.icons.sortAscendingBold
                        : Assets.icons.sortDescendingBold,
                    color: context.colors.background,
                    onPressed: () {
                      isAscending.value = !isAscending.value;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        BlocBuilder<NovelCubit, NovelState>(
          buildWhen: (previous, current) {
            if (current is NovelInfoLoaded) return true;
            if (current is NovelChaptersLoaded) return true;
            return false;
          },
          bloc: context.read<NovelCubit>()..loadChapters(novel!),
          builder: (context, state) {
            if (state is! NovelChaptersLoaded) {
              return const Expanded(
                child: Loading(),
              );
            }

            return Expanded(
              child: ValueListenableBuilder(
                valueListenable: isAscending,
                builder: (context, ascending, child) {
                  return ListView.separated(
                    reverse: !ascending,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: AppDimens.xs),
                    separatorBuilder: (_, __) => const VSpace(AppDimens.md),
                    itemBuilder: (context, index) {
                      final chapter = state.chapters[index];

                      return ChapterTile(
                        number: chapter.number,
                        title: chapter.title,
                        date: chapter.date,
                      );
                    },
                    itemCount: state.chapters.length,
                  );
                },
              ),
            );
          },
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
    return ClickableElement(
      borderRadius: AppDimens.radiusLg,
      onTap: () {
        context.router.push(const ChapterRoute());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.md,
          vertical: AppDimens.sm,
        ),
        color: context.colors.surface,
        child: Row(
          children: [
            Text('$number').textStyle(
              context.textTheme.bodyLg.regular,
              color: context.colors.textSecondary,
            ),
            const HSpace(AppDimens.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).textStyle(
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
            ),
            const Spacer(),
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
