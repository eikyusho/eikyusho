import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/src/library/presentation/cubits/cubits.dart';
import 'package:app/src/library/presentation/widgets/widgets.dart';

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
    return Builder(
      builder: (context) {
        return EmptyPage(
          image: Assets.images.wentWrong,
          message: context.translate.empty_state_error,
          description: context.translate.empty_state_description_error,
        );
      },
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
        final padding = context.screenPadding;

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
              final novel = novels[index];

              return ClickableElement(
                animation: ClickableElementAnimation.grow,
                onTap: () {
                  context.router.push(NovelRoute(novel: novel));
                },
                child: NovelWideCard(
                  title: novel.title,
                  cover: NetworkImage(novel.cover),
                  extension: novel.extension,
                  additionalInfo: novel.additionalInfo,
                ),
              );
            },
            itemCount: novels.length,
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
    return Builder(
      builder: (context) {
        return EmptyPage(
          image: Assets.images.emptyList,
          message: context.translate.empty_state_no_reading_novels,
          description:
              context.translate.empty_state_description_no_reading_novels,
        );
      },
    );
  }

  Widget buildEmptyCompletedNovelsTab() {
    return Builder(
      builder: (context) {
        return EmptyPage(
          image: Assets.images.emptyList,
          message: context.translate.empty_state_no_completed_novels,
          description:
              context.translate.empty_state_description_no_completed_novels,
        );
      },
    );
  }

  Widget buildEmptyCollectionsTab() {
    return Builder(
      builder: (context) {
        return EmptyPage(
          image: Assets.images.emptyList,
          message: context.translate.empty_state_collection,
          description: context.translate.empty_state_description_collection,
        );
      },
    );
  }
}
