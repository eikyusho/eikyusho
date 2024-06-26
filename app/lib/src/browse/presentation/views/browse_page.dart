import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/src/browse/presentation/cubits/cubits.dart';
import 'package:app/src/browse/presentation/widgets/widgets.dart';

@RoutePage()
class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

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
        bloc: context.read<BrowseCubit>()..getSources(),
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is BrowseLoading) return const Loading();

          if (state is BrowseError) throw UnimplementedError();

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
