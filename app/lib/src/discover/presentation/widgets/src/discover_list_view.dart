import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/fake/novels.dart';

class _Styles {
  static const double containerHeight = 232;
}

class DiscoverListHeader extends StatelessWidget {
  const DiscoverListHeader({required this.title, super.key});

  final Text title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title.textStyle(
          context.textTheme.titleSm.bold,
          color: context.colors.textPrimary,
        ),
        AppIconButton(
          Assets.icons.caretRightBold,
          iconColor: context.colors.primary,
          onPressed: () {},
        ),
      ],
    ).px(AppDimens.defaultHorizontalPadding).pb(AppDimens.lg);
  }
}

class DiscoverMostPopularListView extends StatelessWidget {
  const DiscoverMostPopularListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DiscoverListHeader(
          title: Text(AppStrings.discoverListMostPopularTitle),
        ),
        SizedBox(
          height: _Styles.containerHeight,
          child: DiscoverListContent(
            novels: $TempData().getListTwo(),
            isLoading: false,
          ),
        ),
      ],
    );
  }
}

class DiscoverRecentlyUpdatedListView extends StatelessWidget {
  const DiscoverRecentlyUpdatedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DiscoverListHeader(
          title: Text(AppStrings.discoverListRecentlyUpdatedTitle),
        ),
        SizedBox(
          height: _Styles.containerHeight,
          child: DiscoverListContent(
            novels: $TempData().getListThree(),
            isLoading: true,
          ),
        ),
      ],
    );
  }
}

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
