import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/src/search/presentation/cubits/cubits.dart';
import 'package:app/src/search/presentation/widgets/widgets.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        child: SearchAppBar(),
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return switch (state) {
            SearchInitial() => const SizedBox.shrink(),
            SearchLoading() => const Loading(),
            SearchLoaded() => buildPage(state),
            SearchEmpty() => buildEmptyPage(state),
            SearchError() => buildErrorPage(state.error),
          };
        },
      ),
    );
  }

  Widget buildPage(SearchLoaded state) {
    return Builder(
      builder: (context) {
        final padding = context.screenPadding;

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                top: padding.top + AppDimens.sm,
                left: AppDimens.defaultHorizontalPadding,
                right: AppDimens.defaultHorizontalPadding,
                bottom: AppDimens.lg,
              ),
              sliver: const SliverToBoxAdapter(
                child: SearchShowMode(),
              ),
            ),
            if (state.showTip)
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: AppDimens.defaultHorizontalPadding,
                  right: AppDimens.defaultHorizontalPadding,
                  bottom: AppDimens.lg,
                ),
                sliver: ValueListenableBuilder(
                  valueListenable: context.read<SearchCubit>().globalMode,
                  builder: (context, mode, child) {
                    return SliverToBoxAdapter(
                      child: InfoMessage(
                        icon: Assets.icons.infoBold,
                        message: mode
                            ? context.translate.tip_search_locally
                            : context.translate.tip_search_globally,
                      ),
                    );
                  },
                ),
              ),
            ValueListenableBuilder(
              valueListenable: context.read<SearchCubit>().showMode,
              builder: (context, mode, child) {
                return switch (mode) {
                  ShowMode.list => buildList(state.novels, padding),
                  ShowMode.grid => SliverToBoxAdapter(
                      child: buildGrid(state.novels),
                    )
                };
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildEmptyPage(SearchEmpty state) {
    return Builder(
      builder: (context) {
        return EmptyPage(
          image: Assets.images.notFound,
          message: context.translate.empty_state_no_results_found,
          description:
              context.translate.empty_state_description_no_results_found,
          tip: state.showTip ? context.translate.tip_search_globally : null,
        );
      },
    );
  }

  Widget buildErrorPage(Exception error) {
    return Builder(
      builder: (context) {
        return EmptyPage(
          image: Assets.images.wentWrong,
          message: context.translate.empty_state_error,
          description: context.translate.empty_state_description_error,
          error: error,
        );
      },
    );
  }

  Widget buildList(List<Novel> novels, EdgeInsets padding) {
    return SliverPadding(
      padding: EdgeInsets.only(
        left: AppDimens.defaultHorizontalPadding,
        right: AppDimens.defaultHorizontalPadding,
        bottom: padding.bottom + AppDimens.$2xl,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final novel = novels[index];
            final isLast = index == novels.length - 1;

            return Container(
              margin: EdgeInsets.only(
                bottom: isLast ? 0 : AppDimens.md,
              ),
              child: ClickableElement(
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
              ),
            );
          },
          childCount: novels.length,
        ),
      ),
    );
  }

  Widget buildGrid(List<Novel> novels) {
    return NovelGrid(
      hasPadding: false,
      disableScroll: true,
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
}
