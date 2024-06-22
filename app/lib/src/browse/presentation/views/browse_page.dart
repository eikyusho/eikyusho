import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:app/src/browse/presentation/cubits/cubits.dart';
import 'package:app/src/browse/presentation/widgets/widgets.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<BrowseCubit>()..getEnabledSources(),
      child: const BrowseView(),
    );
  }
}

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPaddingWithAppBar;

    return Scaffold(
      appBar: MainAppBar(
        showLogo: true,
        showNotificationButton: true,
        actionIcon: Assets.icons.planetBold,
        actionButton: () {
          context.pushNamed(AppRoute.extensions);
        },
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<BrowseCubit, BrowseState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return switch (state) {
            BrowseLoading() => const Loading(),
            BrowseError() => buildErrorPage(state.error),
            BrowseLoaded() => buildPage(state, padding),
          };
        },
      ),
    );
  }

  Widget buildPage(BrowseLoaded state, EdgeInsets padding) {
    final sources = state.sources;

    return ListView.separated(
      padding: EdgeInsets.only(
        top: padding.top + AppDimens.$2xl,
        bottom: padding.bottom + AppDimens.$2xl,
        left: AppDimens.defaultHorizontalPadding,
        right: AppDimens.defaultHorizontalPadding,
      ),
      separatorBuilder: (_, __) => const VSpace(AppDimens.md),
      itemBuilder: (BuildContext context, int index) {
        final source = sources[index];

        return ExtensionCard(
          type: ExtensionCardType.installed,
          extension: source,
        );
      },
      itemCount: sources.length,
    );
  }

  Widget buildErrorPage(Exception error) {
    return EmptyPage(
      image: Assets.images.error,
      message: AppStrings.emptyStateError,
      description: AppStrings.emptyStateDescriptionErrorSources,
      error: error,
    );
  }
}
