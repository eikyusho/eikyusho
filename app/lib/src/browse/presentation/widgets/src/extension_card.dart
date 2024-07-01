import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:eikyusho_extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/injector/injector.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:app/src/browse/presentation/cubits/cubits.dart';
import 'package:app/src/browse/presentation/widgets/src/extension_card_button.dart';

enum ExtensionCardType { available, installed, update }

class ExtensionCard extends StatelessWidget {
  const ExtensionCard({required this.type, required this.extension, super.key});

  final ExtensionCardType type;
  final AvailableExtension extension;

  @override
  Widget build(BuildContext context) {
    final isInstalled = extension is InstalledExtension;

    final isDisabled =
        isInstalled && !(extension as InstalledExtension).isEnabled;

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
            Opacity(
              opacity: isDisabled ? 0.5 : 1.0,
              child: ExtensionIcon(extension: extension, imageSize: 56),
            ),
            const HSpace(AppDimens.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(extension.name).textStyle(
                  context.textTheme.bodyLg.medium,
                  color: isDisabled
                      ? context.colors.textAuxiliary
                      : context.colors.textPrimary,
                ),
                buildMetadata(context, isDisabled: isDisabled),
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

  Widget buildVersion(BuildContext context) {
    if (this.extension is! InstalledExtension) {
      return Text(this.extension.version);
    }

    final extension = this.extension as InstalledExtension;

    if (extension.updateVersion == null) {
      return Text(extension.version);
    }

    return Row(
      children: [
        Text(
          extension.version,
          style: TextStyle(color: context.colors.warning),
        ),
        Assets.icons.arrowsClockwiseBold.svg(
          width: AppDimens.iconXs,
          height: AppDimens.iconXs,
          colorFilter: svgColor(context.colors.textAuxiliary),
        ),
        Text(
          extension.updateVersion ?? '',
        ).textStyle(
          context.textTheme.bodySm.medium,
          color: context.colors.success.withGreen(145),
        ),
      ],
    ).gap(AppDimens.xs);
  }

  Widget buildMetadata(BuildContext context, {required bool isDisabled}) {
    if (isDisabled) {
      return Text(
        context.translate.meta_disabled,
        style: TextStyle(color: context.colors.warning),
      );
    }

    return Row(
      children: [
        Text(Language.getName(extension.language)),
        const Separator.dot(),
        buildVersion(context),
      ],
    ).gap(AppDimens.sm).textStyle(
          context.textTheme.bodySm.regular,
          color: context.colors.textSecondary,
        );
  }
}
