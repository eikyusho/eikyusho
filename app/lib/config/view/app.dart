import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:core/core.dart';

import 'package:app/config/router/app_router.dart';
import 'package:app/config/view/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedMode = context.themeMode;

    final isDarkMode = switch (selectedMode) {
      ThemeMode.system => context.isSystemDarkMode,
      ThemeMode.dark => true,
      ThemeMode.light => false,
    };

    SystemChrome.setSystemUIOverlayStyle(
      getUiOverlayStyle(isDarkMode: isDarkMode),
    );

    return AppProvider(
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,

        // Theme
        themeMode: selectedMode,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),

        // Routing
        restorationScopeId: AppConstants.appId,
        routerConfig: AppNavigation.config,
      ),
    );
  }
}
