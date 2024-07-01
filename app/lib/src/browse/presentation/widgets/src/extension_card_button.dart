import 'package:flutter/cupertino.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:app/src/browse/presentation/cubits/cubits.dart';
import 'package:app/src/browse/presentation/widgets/widgets.dart';

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

    if (isInstalled) return buildInstallButton(context);

    return BlocConsumer<ExtensionCardCubit, ExtensionCardState>(
      bloc: context.read<ExtensionCardCubit>(),
      listenWhen: (previous, current) {
        if (current is ExtensionCardDownloaded) return true;
        if (current is ExtensionCardError) return true;
        return false;
      },
      buildWhen: (previous, current) => previous != current,
      listener: showSnackBarMessage,
      builder: (context, state) {
        final isDownloading = state is ExtensionCardDownloading;
        final isDownloaded = state is ExtensionCardDownloaded;

        final buttonAction = type == ExtensionCardType.update
            ? context.read<ExtensionCardCubit>().update
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

  Widget buildInstallButton(BuildContext context) {
    return AppIconButton(
      _Icons.settingsIcon,
      iconSize: AppDimens.iconLg,
      iconColor: context.colors.textAuxiliary,
      color: AppColors.transparent,
      onPressed: () => context.showBottomSheet(
        BlocProvider.value(
          value: context.read<BrowseCubit>(),
          child: ExtensionOptionsBottomSheet(
            extension: extension as InstalledExtension,
          ),
        ),
      ),
    );
  }

  void showSnackBarMessage(BuildContext context, ExtensionCardState state) {
    final isDanger = state is ExtensionCardError;

    final message = switch (state) {
      ExtensionCardDownloaded() => state.isUpdate
          ? context.translate.extension_updated
          : context.translate.extension_installed,
      ExtensionCardError() => state.isUpdate
          ? context.translate.failed_to_update
          : context.translate.failed_to_install,
      _ => '',
    };

    if (message.isEmpty) return;

    context.showSnackBar(
      message: '$message: ${extension.name}',
      color: isDanger ? context.colors.error : context.colors.success,
    );
  }
}
