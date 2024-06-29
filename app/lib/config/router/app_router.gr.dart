// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/common/common.dart' as _i9;
import 'package:app/config/router/app_tabs.dart' as _i1;
import 'package:app/src/browse/presentation/views/browse_page.dart' as _i2;
import 'package:app/src/browse/presentation/views/extensions_page.dart' as _i5;
import 'package:app/src/discover/presentation/views/discover_list_page.dart'
    as _i3;
import 'package:app/src/discover/presentation/views/discover_page.dart' as _i4;
import 'package:app/src/reader/presentation/views/novel_page.dart' as _i6;
import 'package:app/src/reader/presentation/views/reader_page.dart' as _i7;
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/cupertino.dart' as _i11;
import 'package:flutter/material.dart' as _i10;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AppTabsRouter.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AppTabs(),
      );
    },
    BrowseRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BrowsePage(),
      );
    },
    DiscoverListRoute.name: (routeData) {
      final args = routeData.argsAs<DiscoverListRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.DiscoverListPage(
          novels: args.novels,
          title: args.title,
          key: args.key,
        ),
      );
    },
    DiscoverRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DiscoverPage(),
      );
    },
    EmptyDiscoverRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.WrappedRoute(child: const _i4.EmptyDiscoverPage()),
      );
    },
    ExtensionsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.WrappedRoute(child: const _i5.ExtensionsPage()),
      );
    },
    NovelRoute.name: (routeData) {
      final args = routeData.argsAs<NovelRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.WrappedRoute(
            child: _i6.NovelPage(
          novel: args.novel,
          key: args.key,
        )),
      );
    },
    ReaderRoute.name: (routeData) {
      final args = routeData.argsAs<ReaderRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.WrappedRoute(
            child: _i7.ReaderPage(
          chapter: args.chapter,
          chapters: args.chapters,
          key: args.key,
        )),
      );
    },
  };
}

/// generated route for
/// [_i1.AppTabs]
class AppTabsRouter extends _i8.PageRouteInfo<void> {
  const AppTabsRouter({List<_i8.PageRouteInfo>? children})
      : super(
          AppTabsRouter.name,
          initialChildren: children,
        );

  static const String name = 'AppTabsRouter';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BrowsePage]
class BrowseRoute extends _i8.PageRouteInfo<void> {
  const BrowseRoute({List<_i8.PageRouteInfo>? children})
      : super(
          BrowseRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrowseRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DiscoverListPage]
class DiscoverListRoute extends _i8.PageRouteInfo<DiscoverListRouteArgs> {
  DiscoverListRoute({
    required List<_i9.Novel> novels,
    required String title,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
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

  static const _i8.PageInfo<DiscoverListRouteArgs> page =
      _i8.PageInfo<DiscoverListRouteArgs>(name);
}

class DiscoverListRouteArgs {
  const DiscoverListRouteArgs({
    required this.novels,
    required this.title,
    this.key,
  });

  final List<_i9.Novel> novels;

  final String title;

  final _i10.Key? key;

  @override
  String toString() {
    return 'DiscoverListRouteArgs{novels: $novels, title: $title, key: $key}';
  }
}

/// generated route for
/// [_i4.DiscoverPage]
class DiscoverRoute extends _i8.PageRouteInfo<void> {
  const DiscoverRoute({List<_i8.PageRouteInfo>? children})
      : super(
          DiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EmptyDiscoverPage]
class EmptyDiscoverRoute extends _i8.PageRouteInfo<void> {
  const EmptyDiscoverRoute({List<_i8.PageRouteInfo>? children})
      : super(
          EmptyDiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyDiscoverRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ExtensionsPage]
class ExtensionsRoute extends _i8.PageRouteInfo<void> {
  const ExtensionsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ExtensionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExtensionsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.NovelPage]
class NovelRoute extends _i8.PageRouteInfo<NovelRouteArgs> {
  NovelRoute({
    required _i9.Novel novel,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          NovelRoute.name,
          args: NovelRouteArgs(
            novel: novel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'NovelRoute';

  static const _i8.PageInfo<NovelRouteArgs> page =
      _i8.PageInfo<NovelRouteArgs>(name);
}

class NovelRouteArgs {
  const NovelRouteArgs({
    required this.novel,
    this.key,
  });

  final _i9.Novel novel;

  final _i10.Key? key;

  @override
  String toString() {
    return 'NovelRouteArgs{novel: $novel, key: $key}';
  }
}

/// generated route for
/// [_i7.ReaderPage]
class ReaderRoute extends _i8.PageRouteInfo<ReaderRouteArgs> {
  ReaderRoute({
    required _i9.Chapter chapter,
    required List<_i9.Chapter> chapters,
    _i11.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ReaderRoute.name,
          args: ReaderRouteArgs(
            chapter: chapter,
            chapters: chapters,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ReaderRoute';

  static const _i8.PageInfo<ReaderRouteArgs> page =
      _i8.PageInfo<ReaderRouteArgs>(name);
}

class ReaderRouteArgs {
  const ReaderRouteArgs({
    required this.chapter,
    required this.chapters,
    this.key,
  });

  final _i9.Chapter chapter;

  final List<_i9.Chapter> chapters;

  final _i11.Key? key;

  @override
  String toString() {
    return 'ReaderRouteArgs{chapter: $chapter, chapters: $chapters, key: $key}';
  }
}
