part of 'app_router.dart';

enum _Route {
  discover('/', name: 'Discover'),
  library('/library', name: 'Library'),
  search('/search', name: 'Search'),
  browse('/browse', name: 'Browse'),
  settings('/settings', name: 'Settings'),
  extensions('extensions', name: 'Extensions'),
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
