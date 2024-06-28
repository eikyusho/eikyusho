import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/reader/data/data.dart';
import 'package:app/src/reader/presentation/cubits/cubits.dart';
import 'package:app/src/reader/presentation/widgets/widgets.dart';

@RoutePage()
class NovelPage extends StatelessWidget implements AutoRouteWrapper {
  const NovelPage({required this.novel, super.key});

  final Novel novel;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => NovelCubit(
        getIt<NovelRepository>(),
      )..getNovelDetails(novel),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
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
            NovelInfoLoaded() => buildPage(state, isLoading: true),
            NovelChaptersLoaded() => buildPage(state, isLoading: false),
            NovelError() => buildErrorPage(state),
          };
        },
      ),
    );
  }

  Widget buildPage(NovelState state, {required bool isLoading}) {
    final novel = isLoading
        ? (state as NovelInfoLoaded).novel
        : (state as NovelChaptersLoaded).novel;

    final status = novel.source.getStatus(novel.status);

    AppLogger.debug(novel.status);
    AppLogger.debug(status);
    final novelStatus = getStatus(status);

    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimens.$2xl,
        bottom: AppDimens.$2xl,
        left: AppDimens.defaultHorizontalPadding,
        right: AppDimens.defaultHorizontalPadding,
      ),
      child: Column(
        children: [
          NovelInfo(
            details: novel,
          ),
          const VSpace(AppDimens.$2xl),
          NovelStats(
            chapterCount: novel.chapterCount,
            status: novelStatus,
            viewCount: Formatter.viewCount(novel.viewCount),
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
          const Expanded(
            child: NovelChapters(),
          ),
        ],
      ),
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
