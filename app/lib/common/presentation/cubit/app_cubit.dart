import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

enum AppThemeMode {
  system,
  light,
  dark;

  @override
  String toString() {
    return switch (this) {
      AppThemeMode.system => 'system',
      AppThemeMode.light => 'light',
      AppThemeMode.dark => 'dark'
    };
  }

  static AppThemeMode fromThemeMode(ThemeMode themeMode) {
    return switch (themeMode) {
      ThemeMode.system => AppThemeMode.system,
      ThemeMode.light => AppThemeMode.light,
      ThemeMode.dark => AppThemeMode.dark,
    };
  }

  static ThemeMode fromString(String? value) {
    return switch (value) {
      'system' => ThemeMode.system,
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}

class AppCubit extends Cubit<AppState> {
  AppCubit(this._prefsManager) : super(const AppState());

  final HivePrefsManager _prefsManager;

  Future<void> loadApp() async {
    final prefThemeMode = await _prefsManager.read<String>(
      PreferencesKeys.themeMode,
    );

    final prefLocale = await _prefsManager.read<String>(
      PreferencesKeys.locale,
    );

    final themeMode = AppThemeMode.fromString(prefThemeMode);
    
    final locale = Locale(prefLocale ?? 'en');

    emit(state.copyWith(themeMode: themeMode, locale: locale));
  }

  void setThemeMode(ThemeMode themeMode) {
    _prefsManager.save(
      PreferencesKeys.themeMode,
      AppThemeMode.fromThemeMode(themeMode).toString(),
    );

    emit(state.copyWith(themeMode: themeMode));
  }

  void setLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }
}
