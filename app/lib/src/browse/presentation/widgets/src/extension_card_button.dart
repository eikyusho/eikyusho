import 'package:flutter/cupertino.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:app/src/browse/presentation/cubits/extension_card/extension_card_cubit.dart';
import 'package:app/src/browse/presentation/widgets/src/extension_card.dart';

final class _Icons {
  const _Icons._();

  static final downloadIcon = Assets.icons.arrowDownBold;
  static final settingsIcon = Assets.icons.slidersHorizontalBold;
  static final updateIcon = Assets.icons.arrowsClockwiseBold;
}

class ExtensionCardButton extends StatelessWidget {
  const ExtensionCardButton({
    required this.type,
    required this.extension,
    super.key,
  });

  final ExtensionCardType type;
  final AvailableExtension extension;

  @override
  Widget build(BuildContext context) {
    final isUpdate = type == ExtensionCardType.update;
    final isInstalled = type == ExtensionCardType.installed;

    final idleIcon = isUpdate ? _Icons.updateIcon : _Icons.downloadIcon;

    if (isInstalled) {
      return AppIconButton(
        _Icons.settingsIcon,
        iconSize: AppDimens.iconLg,
        iconColor: context.colors.textAuxiliary,
        color: AppColors.transparent,
      );
    }

    return BlocConsumer<ExtensionCardCubit, ExtensionCardState>(
      bloc: context.read<ExtensionCardCubit>(),
      listenWhen: (previous, current) {
        return current is ExtensionCardDownloaded ||
            current is ExtensionCardError;
      },
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is ExtensionCardDownloaded) {
          return context.showSnackBar(
            message: 'Extension downloaded: ${extension.name}',
          );
        }

        if (state is ExtensionCardError) {
          return context.showSnackBar(
            message: 'Failed to download extension: ${extension.name}',
          );
        }
      },
      builder: (context, state) {
        final isDownloading = state is ExtensionCardDownloading;
        final isDownloaded = state is ExtensionCardDownloaded;

        final buttonAction = type == ExtensionCardType.update
            ? context.read<ExtensionCardCubit>().download
            : context.read<ExtensionCardCubit>().download;

        return ProgressButton(
          context: context,
          progress: state.progress,
          state: state.state,
          idleIcon: idleIcon,
          color: context.colors.surfaceSecondary,
          onTap: isDownloading || isDownloaded ? null : buttonAction,
        );
      },
    );
  }
}
