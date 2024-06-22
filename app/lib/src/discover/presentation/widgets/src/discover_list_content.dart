import 'package:flutter/material.dart';

import 'package:core/core.dart';

import 'package:app/common/common.dart';

class DiscoverListContent extends StatelessWidget {
  const DiscoverListContent({
    required this.novels,
    required this.isLoading,
    super.key,
  });

  final List<Novel> novels;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final novels = this.novels.limit(6);

    if (isLoading) {
      return const Loading();
    }

    if (novels.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          '||REPLACE|| ERROR',
          style: context.textTheme.bodySm.medium,
        ),
      );
    }

    return GridView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: novels.length,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.defaultHorizontalPadding,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: AppDimens.lg,
        mainAxisExtent: context.isTablet
            ? context.responsiveWidth(.2)
            : context.responsiveWidth(.3),
      ),
      itemBuilder: (context, index) {
        final novel = novels[index];
        return NovelCard(
          title: Text(
            '${novel.title}\n',
            maxLines: AppMisc.novelTitleMaxLines,
          ),
          cover: NetworkImage(novel.cover),
        );
      },
    );
  }
}
