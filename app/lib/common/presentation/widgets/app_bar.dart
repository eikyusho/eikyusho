import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/blurred_container.dart';
import 'package:app/common/presentation/widgets/icon_button.dart';

@immutable
final class _Styles {
  const _Styles._();

  static const height = AppDimens.appBarHeight;
  static const buttonsGap = AppDimens.md;
  static const logoLabel = '${AppConstants.appName} Logo';

  static final optionsIcon = Assets.icons.dotsThreeOutlineFill;
  static final notificationIcon = Assets.icons.bellBold;
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.showLogo = false,
    this.showBackButton = false,
    this.showNotificationButton = false,
    this.actionIcon,
    this.actionButton,
  });

  final Widget? title;
  final bool showLogo;
  final bool showBackButton;
  final bool showNotificationButton;

  final SvgGenImage? actionIcon;
  final void Function()? actionButton;

  @override
  Widget build(BuildContext context) {
    assert(
      !(showLogo && title != null) && !(showLogo && showBackButton),
      'Cannot show both logo and title/back button at the same time.',
    );

    return BlurredContainer(
      blur: AppMisc.blurFilter,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: getBlurredBgColor(context),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.$2xl,
                vertical: AppDimens.md,
              ),
              height: _Styles.height,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  if (showLogo)
                    Positioned(
                      left: 0,
                      child: Assets.images.eikyushoLogo.svg(
                        height: AppDimens.logoHeight,
                        colorFilter: ColorFilter.mode(
                          context.colors.textPrimary,
                          AppMisc.blendMode,
                        ),
                        semanticsLabel: _Styles.logoLabel,
                      ),
                    ),
                  if (title != null)
                    Positioned(
                      left: 0,
                      right: 0,
                      child: title!.textStyle(
                        context.textTheme.titleSm.bold,
                        color: context.colors.textPrimary,
                        align: TextAlign.center,
                      ),
                    ),
                  if (showBackButton)
                    Positioned(
                      left: 0,
                      child: AppIconButton(
                        Assets.icons.caretLeftBold,
                        onPressed: () {
                          AppLogger.debug('Back button pressed');
                          if (context.router.canPop()) {
                            context.back();
                          }
                        },
                      ),
                    ),
                  Positioned(
                    right: 0,
                    child: Row(
                      children: [
                        if (actionButton != null)
                          AppIconButton(
                            actionIcon.getOr(_Styles.optionsIcon),
                            onPressed: actionButton,
                          ),
                        if (showNotificationButton)
                          AppIconButton(
                            _Styles.notificationIcon,
                            onPressed: () {},
                          ),
                      ],
                    ).gap(_Styles.buttonsGap),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_Styles.height);
}
