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
    DiscoverRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DiscoverPage(),
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
