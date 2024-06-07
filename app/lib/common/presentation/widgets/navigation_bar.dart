import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/blurred_container.dart';
import 'package:app/common/presentation/widgets/clickable_element.dart';

@immutable
final class _Styles {
  const _Styles._();

  static const iconSize = AppDimens.iconXl;
  static const height = AppDimens.bottomNavigationBarHeight;
  static const itemsGap = AppDimens.xs;
  static const clickAnimation = ClickableElementAnimation.none;

  static final discoverIcon = Assets.icons.house;
  static final libraryIcon = Assets.icons.books;
  static final searchIcon = Assets.icons.magnifyingGlass;
  static final browseIcon = Assets.icons.compass;
  static final settingsIcon = Assets.icons.gear;
}

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  final int selectedIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.screenPadding.bottom;
    final bottomSpace = context.isAndroid ? bottomPadding : AppDimens.none;

    final destinations = [
      NavbarItem(
        icon: _Styles.discoverIcon,
        label: AppStrings.pageDiscoverTitle,
      ),
      NavbarItem(
        icon: _Styles.libraryIcon,
        label: AppStrings.pageLibraryTitle,
      ),
      NavbarItem(
        icon: _Styles.searchIcon,
        label: AppStrings.pageSearchTitle,
      ),
      NavbarItem(
        icon: _Styles.browseIcon,
        label: AppStrings.pageBrowseTitle,
      ),
      NavbarItem(
        icon: _Styles.settingsIcon,
        label: AppStrings.pageSettingsTitle,
      ),
    ];

    return BlurredContainer(
      blur: AppMisc.blurFilter,
      child: Container(
        color: getBlurredBgColor(context),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.xl,
        ),
        height: _Styles.height + bottomSpace,
        child: Row(
          children: List.generate(destinations.length, (index) {
            final destination = destinations[index];
            final color = index == selectedIndex
                ? context.colors.primary
                : context.colors.textSecondary;

            return NavigationItem(
              color: color,
              onTap: () => onTap(index),
              icon: destination.icon,
              label: destination.label,
            );
          }),
        ).gap(_Styles.itemsGap),
      ),
    );
  }
}

class NavbarItem {
  const NavbarItem({required this.icon, required this.label});

  final SvgGenImage icon;
  final String label;
}

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    required this.color,
    required this.onTap,
    required this.icon,
    required this.label,
    super.key,
  });

  final Color color;
  final SvgGenImage icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClickableElement(
        onTap: onTap,
        animation: _Styles.clickAnimation,
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon.svg(
                colorFilter: ColorFilter.mode(color, AppMisc.blendMode),
                width: _Styles.iconSize,
                height: _Styles.iconSize,
              ),
              Text(label).textStyle(
                context.textTheme.bodyXs.medium,
                color: color,
              ),
            ],
          ),
        ).empty(),
      ),
    );
  }
}
