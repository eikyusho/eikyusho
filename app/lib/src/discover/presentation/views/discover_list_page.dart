import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';

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
    return Scaffold(
      appBar: MainAppBar(
        showBackButton: true,
        title: Text(title),
        actionIcon: Assets.icons.dotsThreeOutlineFill,
        actionButton: () {},
      ),
      extendBodyBehindAppBar: true,
      body: novels.isEmpty ? buildEmptyState(context) : buildPage(),
    );
  }

  Widget buildPage() {
    return Builder(
      builder: (context) {
        final padding = context.screenPadding;

        return GridView.builder(
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

            return ClickableElement(
              onTap: () {
                context.router.push(
                  NovelRoute(novel: novel),
                );
              },
              child: NovelCard(
                title: novel.title,
                cover: NetworkImage(novel.cover),
              ),
            );
          },
          itemCount: novels.length,
        );
      },
    );
  }

  Widget buildEmptyState(BuildContext context) {
    return EmptyPage(
      image: Assets.images.notFound,
      message: AppStrings.emptyStateError,
      description: AppStrings.emptyStateErrorLoadingNovel,
      tip: AppStrings.tipOpenWebView,
    );
  }
}
