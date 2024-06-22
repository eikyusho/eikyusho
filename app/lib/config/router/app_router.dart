import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:app/config/router/app_tabs.dart';
import 'package:app/src/browse/presentation/presentation.dart';
import 'package:app/src/discover/presentation/presentation.dart';

enum _Route {
  discover('/', name: 'Discover'),
  library('/library', name: 'Library'),
  search('/search', name: 'Search'),
  browse('/browse', name: 'Browse'),
  settings('/settings', name: 'Settings'),
  extensions('/extensions', name: 'Extensions'),
  novel('/novel', name: 'Novel');

  const _Route(this.path, {required this.name});

  final String path;
  final String name;
}

class AppRoute {
  static const discover = _Route.discover;

  static String library = _Route.library.name;
  static String search = _Route.search.name;
  static String browse = _Route.browse.name;
  static String settings = _Route.settings.name;
  static String extensions = _Route.extensions.name;
  static String novel = _Route.novel.name;
}

class AppNavigation {
  const AppNavigation();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _discoverNavigatorKey = GlobalKey<NavigatorState>();
  static final _libraryNavigatorKey = GlobalKey<NavigatorState>();
  static final _searchNavigatorKey = GlobalKey<NavigatorState>();
  static final _browseNavigatorKey = GlobalKey<NavigatorState>();
  static final _settingsNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter config() {
    return GoRouter(
      initialLocation: _Route.discover.path,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: kDebugMode,
      routes: [
        StatefulShellRoute.indexedStack(
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
}

class RouteBuilder extends GoRoute {
  RouteBuilder({
    required super.path,
    required super.builder,
    super.name,
    super.onExit,
    super.redirect,
    super.routes,
    super.parentNavigatorKey,
  });

  @override
  GoRouterPageBuilder? get pageBuilder {
    return (context, state) {
      return CupertinoPage(
        key: state.pageKey,
        child: builder!(context, state),
      );
    };
  }
}
