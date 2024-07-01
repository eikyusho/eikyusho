import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
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
      extendBodyBehindAppBar: true,
      body: BlocBuilder<NovelCubit, NovelState>(
        builder: (context, state) {
          return switch (state) {
            NovelLoading() => const Loading(),
            NovelLoaded() => buildPage(state),
            NovelError() => buildErrorPage(state),
          };
        },
      ),
    );
  }

  Widget buildPage(NovelLoaded state) {
    final novel = state.novel;

    final status = novel.source.getStatus(novel.status);
    final novelStatus = getStatus(status);

    return Builder(
      builder: (context) {
        final padding = context.screenPadding;

        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: padding.top + AppDimens.$2xl,
                    left: AppDimens.defaultHorizontalPadding,
                    right: AppDimens.defaultHorizontalPadding,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        NovelInfo(
                          details: novel,
                        ),
                        const VSpace(AppDimens.$2xl),
                        NovelStats(
                          chapterCount: novel.chapterCount,
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
                        const NovelChapterHeader(),
                        const VSpace(AppDimens.xs),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(
                    left: AppDimens.defaultHorizontalPadding,
                    right: AppDimens.defaultHorizontalPadding,
                    bottom:
                        AppDimens.$2xl + AppDimens.bottomNavigationBarHeight,
                  ),
                  sliver: state.isLoading
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Loading(),
                        )
                      : NovelChaptersList(chapters: state.chapters),
                ),
              ],
            ),
            const Positioned(
              left: AppDimens.md,
              right: AppDimens.md,
              bottom: 0,
              child: NovelFloatingButton(),
            ),
          ],
        );
      },
    );
  }

  Widget buildErrorPage(NovelError state) {
    return Builder(
      builder: (context) {
        final message = context.translate.empty_state_error;
        final description = context.translate.empty_state_description_error;

        return EmptyPage(
          image: Assets.images.error,
          message: message,
          description: description,
          child: ActionTextButton(
            icon: Assets.icons.infoBold,
            text: context.translate.button_details,
            onTap: () {
              context.showBottomSheet(
                ErrorBottomSheet(
                  message: message,
                  description: description,
                  error: state.error,
                  url: context.read<NovelCubit>().url,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
