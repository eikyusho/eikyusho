import 'package:app/config/app.dart';
import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

@RoutePage()
class DiscoverListPage extends StatelessWidget {
  const DiscoverListPage({
    required this.novels,
    required this.title,
    super.key,
  });

  final String title;
  final List<Novel> novels;

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPaddingWithAppBar;

    return Scaffold(
      appBar: MainAppBar(
        showBackButton: true,
        title: Text(title),
        actionIcon: Assets.icons.dotsThreeOutlineFill,
        actionButton: () {},
      ),
      extendBodyBehindAppBar: true,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: .55,
          crossAxisSpacing: AppDimens.sm,
          mainAxisSpacing: AppDimens.md,
        ),
        padding: EdgeInsets.only(
          top: padding.top + AppDimens.$2xl,
          bottom: padding.bottom + AppDimens.$2xl,
          left: AppDimens.defaultHorizontalPadding,
          right: AppDimens.defaultHorizontalPadding,
        ),
        itemBuilder: (context, index) {
          final novel = novels[index];

          return NovelCard(
            title: novel.title,
            cover: NetworkImage(novel.cover),
          );
        },
        itemCount: novels.length,
      ),
    );
  }
}
