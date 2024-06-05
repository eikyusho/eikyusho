import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../../src/discover/presentation/presentation.dart';
import 'app_router.dart';

part './app_tabs_builders.dart';

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
        DiscoverRoute(),
        DiscoverRoute(),
      ],
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBarBuilder: _appBarBuilder,
      bottomNavigationBuilder: _bottomNavigationBuilder,
    );
  }
}
