import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:app/src/browse/presentation/cubits/extension_card/extension_card_cubit.dart';
import 'package:app/src/browse/presentation/widgets/src/extension_card_button.dart';

enum ExtensionCardType { available, installed, update }

class ExtensionCard extends StatelessWidget {
  const ExtensionCard({required this.type, required this.extension, super.key});

  final ExtensionCardType type;
  final AvailableExtension extension;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExtensionCardCubit(
        getIt<ExtensionsRepository>(),
        extension,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppDimens.md),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          boxShadow: context.shadows.sm,
        ),
        child: Row(
          children: [
            ExtensionIcon(extension: extension, imageSize: 56),
            const HSpace(AppDimens.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(extension.name).textStyle(
                  context.textTheme.bodyLg.medium,
                  color: context.colors.textPrimary,
                ),
                Row(
                  children: [
                    Text(extension.language),
                    const Separator.dot(),
                    Text(extension.version),
                  ],
                ).gap(AppDimens.sm).textStyle(
                      context.textTheme.bodySm.regular,
                      color: context.colors.textSecondary,
                    ),
              ],
            ),
            const Spacer(),
            ExtensionCardButton(
              type: type,
              extension: extension,
            ),
          ],
        ),
      ),
    );
  }
}
