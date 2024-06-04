import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../common/common.dart';

part './app_tabs_builders.dart';

@RoutePage()
class AppTabsRouterPage extends StatelessWidget {
  const AppTabsRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoTabsScaffold(
      animationCurve: Curves.easeInOut,
      routes: [],
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBarBuilder: _appBarBuilder,
      bottomNavigationBuilder: _bottomNavigationBuilder,
    );
  }
}
