import 'package:auto_route/auto_route.dart';

import 'package:app/config/router/app_tabs_router.dart';
import 'package:app/src/discover/presentation/presentation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: AppTabsRouterRoute.page,
          children: [
            AutoRoute(page: DiscoverRoute.page, initial: true),
          ],
        ),
      ];
}
