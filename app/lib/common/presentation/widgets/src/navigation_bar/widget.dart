import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../blurred_container/widget.dart';
import '../clickable_element/widget.dart';

part 'styles.dart';

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
    Widget buildNavItem({
      required int index,
      required SvgGenImage icon,
      required String label,
    }) {
      final color = _Styles.iconColor(
        context,
        isSelected: index == selectedIndex,
      );

      return Expanded(
        child: ClickableElement(
          onTap: () => onTap(index),
          animation: _Styles.clickAnimation,
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: _Styles.navItemAlignment,
              children: [
                icon.svg(
                  colorFilter: ColorFilter.mode(
                    color,
                    _Styles.blendMode,
                  ),
                  width: _Styles.iconSize,
                  height: _Styles.iconSize,
                ),
                Text(
                  label,
                  style: _Styles.labelTextStyle(context, color),
                ),
              ],
            ),
          ).empty(),
        ),
      );
    }

    return BlurredContainer(
      blur: _Styles.blurSigma,
      child: Container(
        color: _Styles.backgroundColor(context),
        padding: _Styles.padding,
        height: _Styles.height,
        child: Row(
          children: [
            buildNavItem(
              index: 0,
              icon: _Styles.discoverIcon,
              label: AppStrings.pageDiscoverTitle,
            ),
            buildNavItem(
              index: 1,
              icon: _Styles.libraryIcon,
              label: AppStrings.pageLibraryTitle,
            ),
            buildNavItem(
              index: 2,
              icon: _Styles.searchIcon,
              label: AppStrings.pageSearchTitle,
            ),
            buildNavItem(
              index: 3,
              icon: _Styles.browseIcon,
              label: AppStrings.pageBrowseTitle,
            ),
            buildNavItem(
              index: 4,
              icon: _Styles.settingsIcon,
              label: AppStrings.pageSettingsTitle,
            ),
          ],
        ).gap(_Styles.itemsGap),
      ),
    );
  }
}
