import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import 'package:app/config/app.dart';
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
          title: Text(context.translate.section_title_most_popular),
          onPressed: (state) {
            context.router.push(
              DiscoverListRoute(
                novels: state.mostPopular,
                title: context.translate.section_title_most_popular,
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
          title: Text(context.translate.section_title_recently_updated),
          onPressed: (state) {
            context.router.navigate(
              DiscoverListRoute(
                novels: state.recentlyUpdated,
                title: context.translate.section_title_recently_updated,
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
