import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/discover/presentation/cubits/discover_cubit.dart';
import 'package:app/src/discover/presentation/widgets/src/select_source_bottom_sheet.dart';
import 'package:app/src/discover/presentation/widgets/widgets.dart';

class DiscoverPageAppBar extends MainAppBar {
  const DiscoverPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MainAppBar(
      showLogo: true,
      showNotificationButton: true,
      actionIcon: Assets.icons.puzzlePieceBold,
      actionButton: () {
        final cubit = context.read<DiscoverCubit>();

        context.showBottomSheet(
          isDismissable: cubit.state is! DiscoverLoading,
          BlocProvider(
            create: (_) => cubit,
            child: const SelectSourceBottomSheet(),
          ),
        );
      },
    );
  }
}

@RoutePage()
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPadding;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: padding.top + AppDimens.$2xl,
        bottom: padding.bottom + AppDimens.$2xl,
      ),
      child: BlocBuilder<DiscoverCubit, DiscoverState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return switch (state) {
            DiscoverLoading() => const Loading(),
            DiscoverError() => throw UnimplementedError(),
            DiscoverEmpty() => const Text('Empty'),
            DiscoverUninitialized() => const Text('Uninitialized'),
            DiscoverLoaded() => buildPage(state),
          };
        },
      ),
    );
  }

  Widget buildPage(DiscoverLoaded state) {
    return Column(
      children: [
        const DiscoverSpotlight().px(AppDimens.defaultHorizontalPadding),
        const VSpace(AppDimens.$4xl),
        const DiscoverMostPopularListView(),
        const VSpace(AppDimens.$2xl),
        const DiscoverRecentlyUpdatedListView(),
      ],
    );
  }
}
