import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/blurred_container/blurred_container.dart';
import 'package:app/common/presentation/widgets/clickable_element/clickable_element.dart';

part 'navigation_bar.styles.dart';

class NavbarItem {
  const NavbarItem({required this.icon, required this.label});

  final SvgGenImage icon;
  final String label;
}

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
    return BlurredContainer(
      blur: _Styles.blurSigma,
      child: Container(
        color: _Styles.backgroundColor(context),
        padding: _Styles.padding,
        height: _Styles.height,
        child: Row(
          children: List.generate(destinations.length, (index) {
            final destination = destinations[index];
            final color = _Styles.currentColor(
              context,
              isSelected: index == selectedIndex,
            );

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
            mainAxisAlignment: _Styles.navItemAlignment,
            children: [
              icon.svg(
                colorFilter: ColorFilter.mode(color, _Styles.blendMode),
                width: _Styles.iconSize,
                height: _Styles.iconSize,
              ),
              Text(label).textStyle(
                _Styles.labelTextStyle(context),
                color: color,
              ),
            ],
          ),
        ).empty(),
      ),
    );
  }
}
