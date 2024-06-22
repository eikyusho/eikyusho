import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/presentation/widgets/widgets.dart';

class NovelPage extends StatelessWidget {
  const NovelPage({required this.novel, super.key});

  final Novel novel;

  @override
  Widget build(BuildContext context) {
    final source = novel.source;

    return Scaffold(
      appBar: MainAppBar(
        showBackButton: true,
        actionIcon: Assets.icons.shareFatBold,
        actionButton: () {},
      ),
      body: Column(
        children: [
          NovelInfo(
            title: novel.title,
            source: source.name,
            language: source.language,
            cover: novel.cover,
            author: 'Author Name',
          ),
          const VSpace(AppDimens.$2xl),
          const NovelStats(
            chapterCount: 2345,
            status: NovelStatus.completed,
            viewCount: 165000,
          ),
          const VSpace(AppDimens.$2xl),
          const NovelDetails(),
          const VSpace(AppDimens.lg),
          Separator.horizontal(
            size: double.infinity,
            color: context.colors.borderDiscreet,
          ),
          const VSpace(AppDimens.sm),
          Expanded(
            child: ColoredBox(
              color: context.colors.background,
              child: const NovelChapters(),
            ),
          ),
        ],
      ).pAll(AppDimens.defaultHorizontalPadding),
    );
  }
}
