import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/interactions/clickable_element.dart';
import 'package:app/common/presentation/widgets/layout/blurred_container.dart';
import 'package:app/src/discover/presentation/cubits/cubits.dart';
import 'package:app/src/search/presentation/presentation.dart';

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
    final destinations = [
      NavbarItem(
        icon: _Icons.discoverIcon,
        label: context.translate.page_title_discover,
      ),
      NavbarItem(
        icon: _Icons.libraryIcon,
        label: context.translate.page_title_library,
      ),
      NavbarItem(
        icon: _Icons.searchIcon,
        label: context.translate.page_title_search,
      ),
      NavbarItem(
        icon: _Icons.browseIcon,
        label: context.translate.page_title_browse,
      ),
      NavbarItem(
        icon: _Icons.settingsIcon,
        label: context.translate.page_title_settings,
      ),
    ];

    return BlurredContainer(
      blur: AppMisc.blurFilter,
      child: Container(
        color: getBlurredBgColor(context),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.xl,
        ),
        height: AppDimens.bottomNavigationBarHeight,
        child: Row(
          children: List.generate(destinations.length, (index) {
            final destination = destinations[index];
            return NavigationItem(
              index: index,
              selected: index == selectedIndex,
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
    required this.index,
    required this.selected,
    required this.onTap,
    required this.icon,
    required this.label,
    super.key,
  });

  final int index;
  final bool selected;
  final SvgGenImage icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = switch (selected) {
      true => context.colors.primary,
      false => context.colors.textSecondary,
    };

    return Expanded(
      child: ClickableElement(
        onTap: onTap,
        onDoubleTap: () {
          switch (index) {
            case 0:
              context.read<DiscoverCubit>().openWebView(context);
              return;
            case 2:
              if (selected) {
                context.read<SearchCubit>().changeGlobalMode(context);
              }
              return;
            case 3:
            default:
              return;
          }
        },
        animation: ClickableElementAnimation.none,
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon.svg(
                colorFilter: svgColor(color),
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
