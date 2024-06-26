import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/browse/presentation/cubits/browse/browse_cubit.dart';
import 'package:app/src/browse/presentation/widgets/widgets.dart';

final browseCubit = getIt<BrowseCubit>();

@RoutePage()
class BrowsePage extends StatelessWidget implements AutoRouteWrapper {
  const BrowsePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => browseCubit..getSources(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPadding;

    return Scaffold(
      appBar: MainAppBar(
        showLogo: true,
        showNotificationButton: true,
        actionIcon: Assets.icons.planetBold,
        actionButton: () {
          context.router.push(const ExtensionsRoute());
        },
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<BrowseCubit, BrowseState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is BrowseLoading) return const Loading();

          if (state is BrowseFailure) throw UnimplementedError();

          final extensions = (state as BrowseLoaded).sources;

          return ListView.separated(
            padding: EdgeInsets.only(
              top: padding.top + AppDimens.$2xl,
              bottom: padding.bottom + AppDimens.$2xl,
              left: AppDimens.defaultHorizontalPadding,
              right: AppDimens.defaultHorizontalPadding,
            ),
            separatorBuilder: (_, __) => const VSpace(AppDimens.md),
            itemBuilder: (BuildContext context, int index) {
              final extension = extensions[index];

              return ExtensionCard(
                type: ExtensionCardType.installed,
                extension: extension,
              );
            },
            itemCount: extensions.length,
          );
        },
      ),
    );
  }
}
