import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../blurred_container/blurred_container.dart';
import '../icon_button/icon_button.dart';

part 'app_bar.styles.dart';

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
      blur: _Styles.blurSigma,
      child: SafeArea(
        child: Column(
          mainAxisSize: _Styles.mainAxisSize,
          children: [
            Container(
              color: _Styles.backgroundColor(context),
              padding: _Styles.padding,
              height: _Styles.height,
              child: Stack(
                alignment: _Styles.alignment,
                fit: StackFit.expand,
                children: [
                  if (showLogo)
                    Positioned(
                      left: 0,
                      child: Assets.images.eikyushoLogo.svg(
                        height: _Styles.logoSize,
                        colorFilter: ColorFilter.mode(
                          _Styles.logoColor(context),
                          _Styles.blendMode,
                        ),
                        semanticsLabel: _Styles.titleLabel,
                      ),
                    ),
                  if (title != null)
                    Positioned(
                      left: 0,
                      right: 0,
                      child: title!.textStyle(
                        _Styles.titleStyle(context),
                        color: _Styles.titleColor(context),
                        align: _Styles.titleAlignment,
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
