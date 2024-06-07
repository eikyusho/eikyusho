import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/src/browse/data/data.dart';
import 'package:app/src/browse/presentation/cubits/cubits.dart';
import 'package:app/src/browse/presentation/widgets/src/extension_card.dart';

class ExtensionsListBuilder<T extends Extension> extends StatelessWidget {
  const ExtensionsListBuilder({
    required this.bottomPadding,
    required this.selector,
    required this.type,
    super.key,
  });

  final double bottomPadding;
  final List<T> Function(ExtensionsLoaded) selector;
  final ExtensionCardType type;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: AppDimens.defaultHorizontalPadding,
        right: AppDimens.defaultHorizontalPadding,
        bottom: AppDimens.lg,
      ),
      sliver: BlocSelector<ExtensionsCubit, ExtensionsState, List<T>>(
        selector: (state) {
          if (state is! ExtensionsLoaded) return [];

          return selector(state);
        },
        builder: (context, extensions) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final extension = extensions[index];
                final isLast = extension == extensions.last;

                return ExtensionCard(extension: extension, type: type).pb(
                  isLast ? AppDimens.none : AppDimens.lg,
                );
              },
              childCount: extensions.length,
            ),
          );
        },
      ),
    );
  }
}
