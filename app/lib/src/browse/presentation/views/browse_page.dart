import 'package:flutter/cupertino.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/browse/presentation/cubits/browse/browse_cubit.dart';
import 'package:app/src/browse/presentation/widgets/widgets.dart';

final browseCubit = getIt<BrowseCubit>();

class BrowsePageAppBar extends MainAppBar {
  const BrowsePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MainAppBar(
      showLogo: true,
      showNotificationButton: true,
      actionIcon: Assets.icons.planetBold,
      actionButton: () {
        context.pushNamed(AppRoute.settings);
      },
    );
  }
}

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPadding;

    return BlocBuilder<BrowseCubit, BrowseState>(
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
    );
  }
}
