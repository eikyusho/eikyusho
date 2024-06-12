import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/interactions/clickable_element.dart';
import 'package:app/common/presentation/widgets/layout/blurred_container.dart';

@immutable
final class _Icons {
  const _Icons._();

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
        icon: _Icons.discoverIcon,
        label: AppStrings.pageDiscoverTitle,
      ),
      NavbarItem(
        icon: _Icons.libraryIcon,
        label: AppStrings.pageLibraryTitle,
      ),
      NavbarItem(
        icon: _Icons.searchIcon,
        label: AppStrings.pageSearchTitle,
      ),
      NavbarItem(
        icon: _Icons.browseIcon,
        label: AppStrings.pageBrowseTitle,
      ),
      NavbarItem(
        icon: _Icons.settingsIcon,
        label: AppStrings.pageSettingsTitle,
      ),
    ];

    return BlurredContainer(
      blur: AppMisc.blurFilter,
      child: Container(
        color: getBlurredBgColor(context),
        padding: EdgeInsets.only(
          right: AppDimens.xl,
          left: AppDimens.xl,
          bottom: bottomSpace,
        ),
        height: AppDimens.bottomNavigationBarHeight + bottomSpace,
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
        ).gap(AppDimens.xs),
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
        animation: ClickableElementAnimation.none,
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon.svg(
                colorFilter: ColorFilter.mode(color, AppMisc.blendMode),
                width: AppDimens.iconXl,
                height: AppDimens.iconXl,
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
