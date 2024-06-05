import 'package:auto_route/auto_route.dart';

import '../../src/discover/presentation/presentation.dart';
import 'app_tabs_router.dart';

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
