import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/src/discover/presentation/cubits/cubits.dart';
import 'package:app/src/discover/presentation/widgets/widgets.dart';

@RoutePage()
class EmptyDiscoverPage extends StatelessWidget implements AutoRouteWrapper {
  const EmptyDiscoverPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => DiscoverContentCubit(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

@RoutePage()
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool canShowBottomSheet(DiscoverState state) {
      if (state is DiscoverEmpty) return false;

      if (state is DiscoverError) {
        if (state.sources == null) {
          return false;
        }
      }

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
          return buildContentErrorPage(context, state.error);
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
      message: context.translate.empty_state_no_sources,
      description: context.translate.empty_state_description_no_sources,
      child: ActionButton(
        icon: null,
        center: true,
        text: context.translate.page_title_browse,
        onTap: () {
          context.router.push(const ExtensionsRoute());
        },
      ),
    );
  }

  Widget buildUninitializedPage(BuildContext context) {
    return EmptyPage(
      image: Assets.images.error,
      message: context.translate.empty_state_no_selected_source,
      description: context.translate.empty_state_description_no_selected_source,
      child: ActionButton(
        center: true,
        icon: Assets.icons.puzzlePieceBold,
        text: context.translate.button_select_source,
        onTap: () {
          context.showBottomSheet(
            BlocProvider(
              create: (_) => context.read<DiscoverCubit>(),
              child: const SelectSourceBottomSheet(),
            ),
          );
        },
      ),
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

  Widget buildContentErrorPage(BuildContext context, Exception error) {
    final message = context.translate.empty_state_error_loading;
    final description = context.translate.empty_state_description_error_loading;

    return EmptyPage(
      image: Assets.images.wentWrong,
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
              error: error,
              url: null,
            ),
          );
        },
      ),
    );
  }
}
