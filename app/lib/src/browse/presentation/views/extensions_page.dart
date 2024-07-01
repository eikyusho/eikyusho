import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/browse/presentation/presentation.dart';
import 'package:app/src/browse/presentation/widgets/widgets.dart';
import 'package:app/src/discover/presentation/presentation.dart';

@RoutePage()
class ExtensionsPage extends StatelessWidget implements AutoRouteWrapper {
  const ExtensionsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExtensionsCubit>()..getExtensionsAndSources(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPaddingWithAppBar;

    final hasOutdated = context.select((ExtensionsCubit cubit) {
      final currentState = cubit.state;

      if (currentState is! ExtensionsLoaded) return false;

      return currentState.hasOutdated;
    });

    return PopScope(
      onPopInvoked: (isPop) {
        context.read<DiscoverCubit>().getSources();
        context.read<BrowseCubit>().getSources();
      },
      child: Scaffold(
        appBar: MainAppBar(
          showBackButton: true,
          title: Text(context.translate.page_title_extensions),
          actionIcon: Assets.icons.dotsThreeOutlineFill,
          actionButton: () {},
        ),
        extendBodyBehindAppBar: true,
        body: BlocSelector<ExtensionsCubit, ExtensionsState, bool>(
          selector: (state) => state is ExtensionsLoaded,
          builder: (context, isLoaded) {
            if (!isLoaded) return const Loading();

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: VSpace(padding.top + AppDimens.$2xl),
                ),
                if (hasOutdated) ...[
                  SectionTitle(
                    title: context.translate.section_title_pending_updates,
                  ),
                  ExtensionsListBuilder(
                    bottomPadding: AppDimens.lg,
                    selector: (state) => state.outdated,
                    type: ExtensionCardType.update,
                  ),
                ],
                SectionTitle(
                  title: context.translate.section_title_available_extensions,
                ),
                ExtensionsListBuilder(
                  bottomPadding: AppDimens.$2xl,
                  selector: (state) => state.available,
                  type: ExtensionCardType.available,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
