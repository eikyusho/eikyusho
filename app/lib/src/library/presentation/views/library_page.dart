import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/src/library/presentation/cubits/cubits.dart';
import 'package:app/src/library/presentation/widgets/widgets.dart';
import 'package:resources/resources.dart';

@RoutePage()
class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MainAppBar(
          showLogo: true,
          actionButton: () {},
          showNotificationButton: true,
          bottom: const LibraryTabs(),
        ),
        extendBodyBehindAppBar: true,
        body: BlocBuilder<LibraryCubit, LibraryState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return switch (state) {
              LibraryLoading() => const Loading(),
              LibraryLoaded() => buildPage(state),
              LibraryError() => buildErrorPage(),
            };
          },
        ),
      ),
    );
  }

  Widget buildPage(LibraryLoaded state) {
    final readingNovels =
        state.novels.where((novel) => novel.isCompleted == false).toList();
    final completedNovels =
        state.novels.where((novel) => novel.isCompleted ?? false).toList();

    return Column(
      children: [
        Expanded(
          child: TabBarView(
            children: [
              if (readingNovels.isEmpty)
                buildEmptyReadingNovelsTab()
              else
                buildNovelsListTab(readingNovels),
              if (completedNovels.isEmpty)
                buildEmptyCompletedNovelsTab()
              else
                buildNovelsGridTab(completedNovels),
              if (false) buildEmptyCollectionsTab() else buildCollectionsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildErrorPage() {
    return EmptyPage(
      image: Assets.images.wentWrong,
      message: AppStrings.emptyStateError,
      description: AppStrings.emptyStateDescriptionError,
    );
  }

  Widget buildNovelsGridTab(List<Novel> novels) {
    return NovelGrid(
      novels: novels,
      builder: (context, novel) {
        return ClickableElement(
          animation: ClickableElementAnimation.grow,
          onTap: () {
            context.router.push(NovelRoute(novel: novel));
          },
          child: NovelCard(
            title: novel.title,
            cover: NetworkImage(novel.cover),
            extension: novel.extension,
          ),
        );
      },
    );
  }

  Widget buildNovelsListTab(List<Novel> novels) {
    return Builder(
      builder: (context) {
        final height = context.screenHeight;

        return SizedBox(
          height: height,
          child: NovelList(
            novels: novels,
            builder: (context, novel) {
              return ClickableElement(
                animation: ClickableElementAnimation.grow,
                onTap: () {
                  context.router.push(NovelRoute(novel: novel));
                },
                child: NovelWideCard(
                  title: novel.title,
                  cover: NetworkImage(novel.cover),
                  extension: novel.extension,
                  author: novel.novelAuthor,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildCollectionsTab() {
    return Builder(
      builder: (context) {
        final padding = context.screenPadding;
        final height = context.screenHeight;

        return SizedBox(
          height: height,
          child: ListView.separated(
            padding: EdgeInsets.only(
              top: padding.top + AppDimens.$2xl,
              bottom: padding.bottom + AppDimens.$2xl,
              left: AppDimens.defaultHorizontalPadding,
              right: AppDimens.defaultHorizontalPadding,
            ),
            separatorBuilder: (_, __) => const VSpace(AppDimens.md),
            itemBuilder: (context, index) {
              return const CollectionCard();
            },
            itemCount: 3,
          ),
        );
      },
    );
  }

  Widget buildEmptyReadingNovelsTab() {
    return EmptyPage(
      image: Assets.images.emptyList,
      message: AppStrings.emptyStateNoReadingNovels,
      description: AppStrings.emptyStateDescriptionNoReadingNovels,
    );
  }

  Widget buildEmptyCompletedNovelsTab() {
    return EmptyPage(
      image: Assets.images.emptyList,
      message: AppStrings.emptyStateNoCompletedNovels,
      description: AppStrings.emptyStateDescriptionNoCompletedNovels,
    );
  }

  Widget buildEmptyCollectionsTab() {
    return EmptyPage(
      image: Assets.images.emptyList,
      message: AppStrings.emptyStateCollection,
      description: AppStrings.emptyStateDescriptionCollection,
    );
  }
}
