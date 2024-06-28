import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/reader/data/data.dart';
import 'package:app/src/reader/presentation/cubits/cubits.dart';
import 'package:app/src/reader/presentation/cubits/novel_cubit/novel_cubit.dart';
import 'package:app/src/reader/presentation/widgets/widgets.dart';

@RoutePage()
class NovelPage extends StatelessWidget implements AutoRouteWrapper {
  const NovelPage({required this.novel, super.key});

  final Novel novel;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      NovelCubit(
        getIt<NovelRepository>(),
      )
        ..getNovelDetails(novel),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAscending = ValueNotifier(true);

    return Scaffold(
      appBar: MainAppBar(
        showBackButton: true,
        actionIcon: Assets.icons.shareFatBold,
        actionButton: () {},
      ),
      body: BlocBuilder<NovelCubit, NovelState>(
        builder: (context, state) {
          return switch (state) {
            NovelLoading() => const Loading(),
            NovelLoaded() => buildPage(state, isAscending),
            NovelError() => buildErrorPage(state),
          };
        },
      ),
    );
  }

  Widget buildPage(NovelLoaded state, ValueNotifier<bool> isAscending) {
    final novel = state.novel;

    final status = novel.source.getStatus(novel.status);
    final novelStatus = getStatus(status);

    return ListView(
      padding: const EdgeInsets.only(
        top: AppDimens.$2xl,
        bottom: AppDimens.$2xl,
        left: AppDimens.defaultHorizontalPadding,
        right: AppDimens.defaultHorizontalPadding,
      ),
      children: [
        NovelInfo(
          details: novel,
        ),
        const VSpace(AppDimens.$2xl),
        NovelStats(
          chapterCount: novel.chapters,
          status: novelStatus,
          viewCount: Formatter.viewCount(novel.views),
        ),
        const VSpace(AppDimens.$2xl),
        ExpandableDetails(
          description: novel.description,
          genres: novel.genres,
        ),
        const VSpace(AppDimens.lg),
        Builder(
          builder: (context) {
            return Separator.horizontal(
              size: double.infinity,
              color: context.colors.borderDiscreet,
            );
          },
        ),
        const VSpace(AppDimens.sm),
        NovelChapters(novel: novel, isAscending: isAscending),
      ],
    );
  }

  Widget buildErrorPage(NovelError state) {
    return EmptyPage(
      image: Assets.images.error,
      message: AppStrings.emptyStateError,
      description: AppStrings.emptyStateDescriptionError,
      error: state.error,
      actionText: AppStrings.buttonWebView,
      onAction: () {},
    );
  }
}
