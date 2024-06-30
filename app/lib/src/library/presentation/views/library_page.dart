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
              buildNovelsTab(readingNovels),
              buildNovelsTab(completedNovels),
              buildCollectionsTab(),
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

  Widget buildNovelsTab(List<Novel> novels) {
    return NovelGrid(
      novels: novels,
      builder: (context, novel) {
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

  Widget buildCollectionsTab() {
    return Builder(
      builder: (context) {
        final padding = context.screenPadding;

        return SingleChildScrollView(
          padding: EdgeInsets.only(
            top: padding.top + AppDimens.$2xl,
            bottom: padding.bottom + AppDimens.$2xl,
          ),
          child: const Column(),
        );
      },
    );
  }
}
