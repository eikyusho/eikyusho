import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:app/common/common.dart';
import 'package:app/config/router/app_router.dart';

@RoutePage()
class AppTabsRouterPage extends StatelessWidget {
  const AppTabsRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoTabsScaffold(
      animationCurve: Curves.easeInOut,
      routes: [
        DiscoverRoute(),
        DiscoverRoute(),
        DiscoverRoute(),
        BrowseRoute(),
        DiscoverRoute(),
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
