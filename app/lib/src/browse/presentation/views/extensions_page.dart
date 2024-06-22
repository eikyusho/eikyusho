import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:app/src/browse/presentation/presentation.dart';
import 'package:app/src/browse/presentation/widgets/widgets.dart';
import 'package:app/src/discover/presentation/presentation.dart';

class ExtensionsPage extends StatelessWidget {
  const ExtensionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExtensionsCubit(
        getIt<ExtensionsRepository>(),
      )..getExtensionsAndSources(),
      child: PopScope(
        onPopInvoked: (isPop) {
          context.read<DiscoverCubit>().getSources();
          context.read<BrowseCubit>().getEnabledSources();
        },
        child: const ExtensionsView(),
      ),
    );
  }
}

class ExtensionsView extends StatelessWidget {
  const ExtensionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPaddingWithAppBar;

    final hasOutdated = context.select((ExtensionsCubit cubit) {
      final currentState = cubit.state;

      if (currentState is! ExtensionsLoaded) return false;

      return currentState.hasOutdated;
    });

    return Scaffold(
      appBar: MainAppBar(
        showBackButton: true,
        title: Text(AppStrings.pageExtensionsTitle),
        actionIcon: Assets.icons.dotsThreeOutlineFill,
        actionButton: () {},
      ),
      extendBodyBehindAppBar: true,
      body: BlocSelector<ExtensionsCubit, ExtensionsState, bool>(
        selector: (state) => state is ExtensionsLoaded,
        builder: (context, isLoaded) {
          return switch (isLoaded) {
            false => const Loading(),
            true => buildPage(padding, hasOutdated: hasOutdated),
          };
        },
      ),
    );
  }

  Widget buildPage(EdgeInsets padding, {required bool hasOutdated}) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: VSpace(padding.top + AppDimens.$2xl),
        ),
        if (hasOutdated) ...[
          SectionTitle(title: AppStrings.sectionTitlePendingUpdates),
          ExtensionsListBuilder(
            bottomPadding: AppDimens.lg,
            selector: (state) => state.outdated,
            type: ExtensionCardType.update,
          ),
        ],
        SectionTitle(title: AppStrings.sectionTitleAvailableExtensions),
        ExtensionsListBuilder(
          bottomPadding: AppDimens.$2xl,
          selector: (state) => state.available,
          type: ExtensionCardType.available,
        ),
      ],
    );
  }
}
