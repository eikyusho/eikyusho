import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:app/src/browse/presentation/presentation.dart';

class ExtensionOptionsBottomSheet extends StatelessWidget {
  const ExtensionOptionsBottomSheet({required this.extension, super.key});

  final InstalledExtension extension;

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      children: [
        ExtensionIcon(
          extension: extension,
          imageSize: 80,
        ),
        const VSpace(AppDimens.md),
        Text(extension.name).textStyle(
          context.textTheme.titleSm.bold,
          color: context.colors.textPrimary,
        ),
        const VSpace(AppDimens.xs),
        Text(extension.baseUrl).textStyle(
          context.textTheme.bodySm.regular,
          color: context.colors.textSecondary,
        ),
        const VSpace(AppDimens.lg),
        Row(
          children: [
            ExtensionMeta(
              label: AppStrings.labelVersion,
              value: extension.version,
            ),
            const Separator.vertical(size: 40),
            ExtensionMeta(
              label: AppStrings.labelLanguage,
              value: extension.language,
            ),
          ],
        ),
        const VSpace(AppDimens.lg),
        ToggleTile(
          text: AppStrings.toggleActiveExtension,
          value: extension.isEnabled,
          onTap: (value) {
            if (value) {
              browseCubit.enableExtension(extension);
            } else {
              browseCubit.disableExtension(extension);
            }
          },
        ),
        const VSpace(AppDimens.md),
        ActionButton(
          icon: Assets.icons.trashBold,
          text: AppStrings.buttonUninstallExtension,
          dangerAction: true,
          onTap: () async {
            await showDialog<void>(
              context: context,
              builder: (context) => AppDialog(
                type: DialogType.danger,
                title: Text(AppStrings.dialogUninstallExtension),
                description: Text(
                  AppStrings.dialogDescriptionUninstallExtension,
                ),
                onConfirm: () {},
              ),
            );
          },
        ),
      ],
    );
  }
}

class ExtensionMeta extends StatelessWidget {
  const ExtensionMeta({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label).textStyle(
          context.textTheme.bodyXs.medium,
          color: context.colors.textAuxiliary,
        ),
        Text(value).textStyle(
          context.textTheme.bodyLg.bold,
          color: context.colors.primary,
        ),
      ],
    ).expanded();
  }
}
