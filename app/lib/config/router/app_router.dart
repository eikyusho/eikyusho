import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';

import 'package:app/config/router/app_router.gr.dart';
import 'package:app/injector/injector.dart';

class AppNavigation {
  const AppNavigation();

  static late final String _initialLocation;

  static Future<void> setupRouter() async {
    _initialLocation = await _getInitialLocation();
  }

  static Future<String> _getInitialLocation() async {
    final prefs = getIt<HivePrefsManager>();

    final location = await prefs.read<String>(PreferencesKeys.initialLocation);

    return location ?? DiscoverRoute.name;
  }
}

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  bool get isLibraryInitial {
    return AppNavigation._initialLocation == LibraryRoute.name;
  }

  bool get isDiscoverInitial {
    return !isLibraryInitial;
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: AppTabsRouter.page,
          children: [
            AutoRoute(
              page: EmptyDiscoverRoute.page,
              initial: isDiscoverInitial,
              children: [
                AutoRoute(page: DiscoverRoute.page, initial: true),
                AutoRoute(page: DiscoverListRoute.page),
              ],
            ),
            AutoRoute(page: LibraryRoute.page, initial: isLibraryInitial),
            AutoRoute(page: SearchRoute.page),
            AutoRoute(page: BrowseRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
        AutoRoute(page: ExtensionsRoute.page),
        AutoRoute(page: NovelRoute.page),
        AutoRoute(page: ReaderRoute.page),
        AutoRoute(page: WebViewRoute.page),
      ];
}
