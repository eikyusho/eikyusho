import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import 'package:app/common/presentation/cubit/app_cubit.dart';
import 'package:app/config/router/app_router.dart';
import 'package:app/config/view/provider.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final selectedMode = state.themeMode;

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

            // Localization
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

            locale: state.locale,

            // Routing
            restorationScopeId: AppConstants.appId,
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
