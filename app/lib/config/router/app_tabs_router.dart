import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:app/common/common.dart';
import 'package:app/config/router/app_router.dart';
import 'package:app/src/browse/presentation/presentation.dart';
import 'package:app/src/discover/presentation/presentation.dart';

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
        BrowseRoute(),
        DiscoverRoute(),
      ],
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBarBuilder: _appBarBuilder,
      bottomNavigationBuilder: _bottomNavigationBuilder,
    );
  }
}
