import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';

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
    final novels = this.novels.take(6).toList();

    if (isLoading) {
      return const Loading();
    }

    if (novels.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.notFound.image(
            width: context.responsiveWidth(.5),
          ),
          const VSpace(AppDimens.md),
          Text(AppStrings.emptyStateErrorLoadingNovel).textStyle(
            context.textTheme.bodySm.medium,
            color: context.colors.textPrimary,
          ),
        ],
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
        return ClickableElement(
          onTap: () {
            context.router.push(NovelRoute(novel: novel));
          },
          child: NovelCard(
            title: novel.title,
            cover: NetworkImage(novel.cover),
          ),
        );
      },
    );
  }
}
