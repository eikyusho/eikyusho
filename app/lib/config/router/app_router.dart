import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:app/config/router/app_tabs.dart';
import 'package:app/src/browse/presentation/presentation.dart';
import 'package:app/src/discover/presentation/presentation.dart';

part 'app_routes.dart';

class AppNavigation {
  const AppNavigation();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _discoverNavigatorKey = GlobalKey<NavigatorState>();
  static final _libraryNavigatorKey = GlobalKey<NavigatorState>();
  static final _searchNavigatorKey = GlobalKey<NavigatorState>();
  static final _browseNavigatorKey = GlobalKey<NavigatorState>();
  static final _settingsNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter config = GoRouter(
    initialLocation: _Route.discover.path,
    navigatorKey: _rootNavigatorKey,
    restorationScopeId: 'app_router',
    debugLogDiagnostics: kDebugMode,
    routes: [
      StatefulShellRoute.indexedStack(
        restorationScopeId: 'tabs_shell',
        pageBuilder: (context, state, navigationShell) {
          return CupertinoPage(
            child: TabsScaffold(
              navigationShell: navigationShell,
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _discoverNavigatorKey,
            routes: [
              RouteBuilder(
                path: _Route.discover.path,
                name: _Route.discover.name,
                builder: (context, state) {
                  return const DiscoverPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _libraryNavigatorKey,
            routes: [
              RouteBuilder(
                path: _Route.library.path,
                name: _Route.library.name,
                builder: (context, state) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Library'),
                    ),
                    body: const Text('Library'),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _searchNavigatorKey,
            routes: [
              RouteBuilder(
                path: _Route.search.path,
                name: _Route.search.name,
                builder: (context, state) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Search'),
                    ),
                    body: const Text('Search'),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _browseNavigatorKey,
            routes: [
              RouteBuilder(
                path: _Route.browse.path,
                name: _Route.browse.name,
                builder: (context, state) {
                  return const BrowsePage();
                },
                routes: [
                  RouteBuilder(
                    path: _Route.extensions.path,
                    name: _Route.extensions.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      return const ExtensionsPage();
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              RouteBuilder(
                path: _Route.settings.path,
                name: _Route.settings.name,
                builder: (context, state) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Settings'),
                    ),
                    body: const Text('Settings'),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
