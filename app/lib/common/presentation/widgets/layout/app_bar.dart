import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/buttons/icon_button.dart';
import 'package:app/common/presentation/widgets/layout/blurred_container.dart';

@immutable
final class _Icons {
  const _Icons._();

  static final options = Assets.icons.dotsThreeOutlineFill;
  static final notifications = Assets.icons.bellBold;
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
    this.onBack,
  });

  final Widget? title;
  final bool showLogo;
  final bool showBackButton;
  final bool showNotificationButton;

  final SvgGenImage? actionIcon;
  final VoidCallback? actionButton;
  final VoidCallback? onBack;

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
              height: AppDimens.appBarHeight,
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
                        semanticsLabel: '${AppConstants.appName} Logo',
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
                            onBack?.call();
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
                            actionIcon.getOr(_Icons.options),
                            onPressed: actionButton,
                          ),
                        if (showNotificationButton)
                          AppIconButton(
                            _Icons.notifications,
                            onPressed: () {},
                          ),
                      ],
                    ).gap(AppDimens.md),
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
  Size get preferredSize => const Size.fromHeight(AppDimens.appBarHeight);
}
