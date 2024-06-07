import 'package:flutter/cupertino.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/browse/presentation/widgets/src/extension_card.dart';

final class _Styles {
  const _Styles._();

  static final downloadIcon = Assets.icons.arrowDownBold;
  static final settingsIcon = Assets.icons.slidersHorizontalBold;
  static final updateIcon = Assets.icons.arrowsClockwiseBold;
}

class ExtensionCardButton extends StatelessWidget {
  const ExtensionCardButton({required this.type, super.key});

  final ExtensionCardType type;

  @override
  Widget build(BuildContext context) {
    final isUpdate = type == ExtensionCardType.update;
    final isInstalled = type == ExtensionCardType.installed;

    final idleIcon = isUpdate ? _Styles.updateIcon : _Styles.downloadIcon;

    if (isInstalled) {
      return AppIconButton(
        _Styles.settingsIcon,
        iconSize: AppDimens.iconLg,
        iconColor: context.colors.textAuxiliary,
        color: AppColors.transparent,
      );
    }

    final buttonState = ButtonStateNotifier();

    return ListenableBuilder(
      listenable: buttonState,
      builder: (context, _) {
        return ProgressButton(
          context: context,
          progress: buttonState._progress,
          state: buttonState._state,
          idleIcon: idleIcon,
          color: context.colors.surfaceSecondary,
          onTap: buttonState._downloading
              ? null
              : () => _download(buttonState, context),
        );
      },
    );
  }

  Future<void> _download(ButtonStateNotifier notifier, BuildContext ctx) async {
    await notifier.startDownload();
    for (var i = 0; i <= 1000; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 1));
      notifier.updateProgress(i);
    }
    notifier.finishDownload(ProgressButtonState.failed);
  }
}

@protected
class ButtonStateNotifier extends ChangeNotifier {
  bool _downloading = false;
  double _progress = 0;
  ProgressButtonState _state = ProgressButtonState.idle;

  Future<void> startDownload() async {
    _downloading = true;
    _progress = 0;
    _state = ProgressButtonState.inProgress;
    notifyListeners();
  }

  void updateProgress(int progress) {
    _progress = progress / 1000;
    notifyListeners();
  }

  void finishDownload(ProgressButtonState state) {
    _downloading = false;
    _state = state;
    notifyListeners();
  }
}
