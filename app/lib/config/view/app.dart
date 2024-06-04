import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../router/app_router.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),

      // Routing
      restorationScopeId: AppConstants.appId,
      routerConfig: _appRouter.config(),
    );
  }
}
