import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/library/data/data.dart';
import 'package:app/src/search/data/data.dart';
import 'package:app/src/search/presentation/cubits/cubits.dart';
import 'package:app/src/search/presentation/widgets/widgets.dart';

@RoutePage()
class SearchPage extends StatelessWidget implements AutoRouteWrapper {
  const SearchPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        getIt<SearchRepository>(),
        getIt<LibraryRepository>(),
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        child: SearchAppBar(),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return switch (state) {
            SearchInitial() => const SizedBox.shrink(),
            SearchLoading() => const Loading(),
            SearchLoaded() => buildPage(state),
            SearchError() => buildErrorPage(state.error),
          };
        },
      ),
    );
  }

  Widget buildPage(SearchLoaded state) {
    return Column(
      children: [
        Expanded(
          child: buildGrid(state.novels),
        ),
      ],
    );
  }

  Widget buildErrorPage(Exception error) {
    return EmptyPage(
      image: Assets.images.wentWrong,
      message: AppStrings.emptyStateError,
      description: AppStrings.emptyStateDescriptionError,
      error: error,
    );
  }

  Widget buildGrid(List<Novel> novels) {
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
}
