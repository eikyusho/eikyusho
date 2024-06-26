import 'package:app/config/app.dart';
import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/src/discover/presentation/cubits/cubits.dart';
import 'package:app/src/discover/presentation/widgets/src/discover_list_content.dart';
import 'package:app/src/discover/presentation/widgets/src/discover_list_header.dart';

const double kContainerHeight = 232;

class DiscoverMostPopularListView extends StatelessWidget {
  const DiscoverMostPopularListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DiscoverListHeader(
          title: Text(AppStrings.discoverListMostPopularTitle),
          onPressed: (state) {
            context.router.push(
              DiscoverListRoute(
                novels: state.mostPopular,
                title: AppStrings.discoverListMostPopularTitle,
              ),
            );
          },
        ),
        BlocBuilder<DiscoverContentCubit, DiscoverContentState>(
          builder: (context, state) {
            state as DiscoverContentInitial;

            return SizedBox(
              height: kContainerHeight,
              child: DiscoverListContent(
                novels: state.mostPopular,
                isLoading: state.mostPopularLoading,
              ),
            );
          },
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
          onPressed: (state) {
            context.router.navigate(
              DiscoverListRoute(
                novels: state.recentlyUpdated,
                title: AppStrings.discoverListRecentlyUpdatedTitle,
              ),
            );
          },
        ),
        BlocBuilder<DiscoverContentCubit, DiscoverContentState>(
          builder: (context, state) {
            state as DiscoverContentInitial;

            return SizedBox(
              height: kContainerHeight,
              child: DiscoverListContent(
                novels: state.recentlyUpdated,
                isLoading: state.recentlyUpdatedLoading,
              ),
            );
          },
        ),
      ],
    );
  }
}
