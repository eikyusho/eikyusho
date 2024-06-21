// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AppTabsRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppTabsRouterPage(),
      );
    },
    BrowseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const BrowsePage()),
      );
    },
    DiscoverRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const DiscoverPage()),
      );
    },
    ExtensionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ExtensionsPage()),
      );
    },
    NovelRoute.name: (routeData) {
      final args = routeData.argsAs<NovelRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NovelPage(
          novel: args.novel,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [AppTabsRouterPage]
class AppTabsRouterRoute extends PageRouteInfo<void> {
  const AppTabsRouterRoute({List<PageRouteInfo>? children})
      : super(
          AppTabsRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppTabsRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BrowsePage]
class BrowseRoute extends PageRouteInfo<void> {
  const BrowseRoute({List<PageRouteInfo>? children})
      : super(
          BrowseRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrowseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DiscoverPage]
class DiscoverRoute extends PageRouteInfo<void> {
  const DiscoverRoute({List<PageRouteInfo>? children})
      : super(
          DiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExtensionsPage]
class ExtensionsRoute extends PageRouteInfo<void> {
  const ExtensionsRoute({List<PageRouteInfo>? children})
      : super(
          ExtensionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExtensionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NovelPage]
class NovelRoute extends PageRouteInfo<NovelRouteArgs> {
  NovelRoute({
    required Novel novel,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          NovelRoute.name,
          args: NovelRouteArgs(
            novel: novel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'NovelRoute';

  static const PageInfo<NovelRouteArgs> page = PageInfo<NovelRouteArgs>(name);
}

class NovelRouteArgs {
  const NovelRouteArgs({
    required this.novel,
    this.key,
  });

  final Novel novel;

  final Key? key;

  @override
  String toString() {
    return 'NovelRouteArgs{novel: $novel, key: $key}';
  }
}
