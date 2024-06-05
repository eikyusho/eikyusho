import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../router/app_router.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final selectedMode = context.themeMode;

        final isDarkMode = switch (selectedMode) {
          ThemeMode.system => context.isSystemDarkMode,
          ThemeMode.dark => true,
          ThemeMode.light => false,
        };

        SystemChrome.setSystemUIOverlayStyle(
          getUiOverlayStyle(isDarkMode: isDarkMode),
        );

        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,

          // Theme
          themeMode: selectedMode,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),

          // Routing
          restorationScopeId: AppConstants.appId,
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}
