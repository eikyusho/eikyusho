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
    final showDisabled = ValueNotifier(false);
    final padding = context.screenPaddingWithAppBar;

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
      body: Padding(
        padding: EdgeInsets.only(
          top: padding.top + AppDimens.$2xl,
          bottom: padding.bottom + AppDimens.$2xl,
          left: AppDimens.defaultHorizontalPadding,
          right: AppDimens.defaultHorizontalPadding,
        ),
        child: Column(
          children: [
            // const VSpace(AppDimens.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.toggleShowDisabled).textStyle(
                  context.textTheme.bodyMd.medium,
                  color: context.colors.textPrimary,
                ),
                ValueListenableBuilder(
                  valueListenable: showDisabled,
                  builder: (context, value, child) {
                    return Toggle(
                      value: showDisabled.value,
                      onChanged: (value) {
                        showDisabled.value = value;
                      },
                    );
                  },
                ),
              ],
            ),
            const VSpace(AppDimens.lg),
            BlocBuilder<BrowseCubit, BrowseState>(
              bloc: context.read<BrowseCubit>()..getSources(),
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return switch (state) {
                  BrowseLoading() => const Loading(),
                  BrowseError() => buildErrorPage(state.error),
                  BrowseLoaded() => buildPage(state, showDisabled),
                };
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage(BrowseLoaded state, ValueNotifier<bool> showDisabled) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: showDisabled,
        builder: (context, value, child) {
          final sources = value
              ? state.sources
              : state.sources.where((source) => source.isEnabled).toList();

          return ListView.separated(
            padding: EdgeInsets.zero,
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
        },
      ),
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
