import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:app/common/common.dart';

class TabsScaffold extends StatelessWidget {
  const TabsScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onTap: (index) => goToBranch(index, navigationShell),
      ),
    );
  }

  void goToBranch(int index, StatefulNavigationShell navigationShell) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
