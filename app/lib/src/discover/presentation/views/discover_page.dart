import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/src/discover/presentation/cubits/cubits.dart';
import 'package:app/src/discover/presentation/widgets/widgets.dart';

@RoutePage()
class DiscoverPage extends StatelessWidget implements AutoRouteWrapper {
  const DiscoverPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => DiscoverContentCubit(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool canShowBottomSheet(DiscoverState state) {
      if (state is DiscoverEmpty) return false;

      if (state is DiscoverError) return false;

      return true;
    }

    void showBottomSheet() {
      final cubit = context.read<DiscoverCubit>();

      if (!canShowBottomSheet(cubit.state)) return;

      context.showBottomSheet(
        isDismissable: cubit.state is! DiscoverLoading,
        BlocProvider.value(
          value: context.read<DiscoverCubit>(),
          child: const SelectSourceBottomSheet(),
        ),
      );
    }

    return Scaffold(
      appBar: MainAppBar(
        showLogo: true,
        showNotificationButton: true,
        actionIcon: Assets.icons.puzzlePieceBold,
        actionButton: showBottomSheet,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<DiscoverCubit, DiscoverState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is DiscoverLoaded) {
            context.read<DiscoverContentCubit>().load(state.selected);
          }

          return switch (state) {
            DiscoverLoading() => const Loading(),
            DiscoverError() => buildErrorPage(state.error),
            DiscoverEmpty() => buildEmptyPage(context),
            DiscoverUninitialized() => buildUninitializedPage(context),
            DiscoverLoaded() => buildPage(),
          };
        },
      ),
    );
  }

  Widget buildPage() {
    return BlocBuilder<DiscoverContentCubit, DiscoverContentState>(
      builder: (context, state) {
        final padding = context.screenPadding;

        if (state is DiscoverContentError) {
          return buildContentErrorPage(context);
        }

        return SingleChildScrollView(
          padding: EdgeInsets.only(
            top: padding.top + AppDimens.$2xl,
            bottom: padding.bottom + AppDimens.$2xl,
          ),
          child: const Column(
            children: [
              DiscoverSpotlights(),
              VSpace(AppDimens.$4xl),
              DiscoverMostPopularListView(),
              VSpace(AppDimens.$2xl),
              DiscoverRecentlyUpdatedListView(),
            ],
          ),
        );
      },
    );
  }

  Widget buildEmptyPage(BuildContext context) {
    return EmptyPage(
      image: Assets.images.emptyList,
      message: AppStrings.emptyStateNoSources,
      description: AppStrings.emptyStateDescriptionNoSources,
      actionText: AppStrings.pageBrowseTitle,
      onAction: () {
        context.router.push(const ExtensionsRoute());
      },
    );
  }

  Widget buildUninitializedPage(BuildContext context) {
    return EmptyPage(
      image: Assets.images.error,
      message: AppStrings.emptyStateNoSelectedSource,
      description: AppStrings.emptyStateDescriptionNoSelectedSource,
      actionText: AppStrings.buttonSelectSource,
      onAction: () {
        context.showBottomSheet(
          BlocProvider(
            create: (_) => context.read<DiscoverCubit>(),
            child: const SelectSourceBottomSheet(),
          ),
        );
      },
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

  Widget buildContentErrorPage(BuildContext context) {
    return EmptyPage(
      image: Assets.images.wentWrong,
      message: AppStrings.emptyStateErrorLoading,
      description: AppStrings.emptyStateDescriptionErrorLoading,
      tip: AppStrings.tipDoubleTapDiscover,
    );
  }
}
