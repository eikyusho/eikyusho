import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:app/common/common.dart';
import 'package:app/config/router/app_router.gr.dart';

@RoutePage(name: 'AppTabsRouter')
class AppTabs extends StatelessWidget {
  const AppTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoTabsScaffold(
      animationCurve: Curves.easeInOut,
      routes: [
        EmptyDiscoverRoute(),
        LibraryRoute(),
        BrowseRoute(),
      ],
      extendBody: true,
      bottomNavigationBuilder: _bottomNavigationBuilder,
    );
  }
}

AppNavigationBar _bottomNavigationBuilder(
  BuildContext _,
  TabsRouter tabsRouter,
) {
  return AppNavigationBar(
    selectedIndex: tabsRouter.activeIndex,
    onTap: (index) {
      tabsRouter.setActiveIndex(index);
    },
  );
}
