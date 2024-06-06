import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/browse/presentation/cubits/cubits.dart';
import 'package:app/src/browse/presentation/widgets/widgets.dart';

@RoutePage()
class ExtensionsPage extends StatelessWidget implements AutoRouteWrapper {
  const ExtensionsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ExtensionsCubit(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPaddingWithAppBar;

    final outdatedExtensions = <String>[''];
    final availableExtensions = <String>[''];

    return Scaffold(
      appBar: MainAppBar(
        showBackButton: true,
        title: Text(AppStrings.pageExtensionsTitle),
        actionIcon: Assets.icons.dotsThreeOutlineFill,
        actionButton: () {},
      ),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: VSpace(padding.top + AppDimens.$2xl),
          ),
          if (outdatedExtensions.isNotEmpty) ...[
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
            selector: (state) => state.outdated,
            type: ExtensionCardType.available,
          ),
        ],
      ),
    );
  }
}
