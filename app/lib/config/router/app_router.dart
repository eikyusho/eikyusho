import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:app/common/common.dart';
import 'package:app/config/router/app_tabs_router.dart';
import 'package:app/src/browse/presentation/presentation.dart';
import 'package:app/src/discover/presentation/presentation.dart';
import 'package:app/src/reader/presentation/presentation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  final isDiscoverInitial = true;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: AppTabsRouterRoute.page,
          children: [
            AutoRoute(page: DiscoverRoute.page, initial: isDiscoverInitial),
            AutoRoute(page: BrowseRoute.page),
          ],
        ),
        AutoRoute(page: ExtensionsRoute.page),
        AutoRoute(page: NovelRoute.page),
      ];
}
