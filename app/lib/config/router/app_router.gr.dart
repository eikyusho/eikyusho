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
        child: const BrowsePage(),
      );
    },
    DiscoverListRoute.name: (routeData) {
      final args = routeData.argsAs<DiscoverListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DiscoverListPage(
          novels: args.novels,
          title: args.title,
          key: args.key,
        ),
      );
    },
    DiscoverRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DiscoverPage(),
      );
    },
    EmptyDiscoverRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const EmptyDiscoverPage()),
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
        child: WrappedRoute(
            child: NovelPage(
          novel: args.novel,
          key: args.key,
        )),
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
/// [DiscoverListPage]
class DiscoverListRoute extends PageRouteInfo<DiscoverListRouteArgs> {
  DiscoverListRoute({
    required List<Novel> novels,
    required String title,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          DiscoverListRoute.name,
          args: DiscoverListRouteArgs(
            novels: novels,
            title: title,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'DiscoverListRoute';

  static const PageInfo<DiscoverListRouteArgs> page =
      PageInfo<DiscoverListRouteArgs>(name);
}

class DiscoverListRouteArgs {
  const DiscoverListRouteArgs({
    required this.novels,
    required this.title,
    this.key,
  });

  final List<Novel> novels;

  final String title;

  final Key? key;

  @override
  String toString() {
    return 'DiscoverListRouteArgs{novels: $novels, title: $title, key: $key}';
  }
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
/// [EmptyDiscoverPage]
class EmptyDiscoverRoute extends PageRouteInfo<void> {
  const EmptyDiscoverRoute({List<PageRouteInfo>? children})
      : super(
          EmptyDiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyDiscoverRoute';

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
