final class AppConstants {
  const AppConstants._();

  // * || App
  static const String appName = 'Eikyusho';
  static const String appId = 'com.eikyusho.app';

  // * || Timeouts
  /// Duration: 30s
  static const Duration connectTimeout = Duration(seconds: 30);

  /// Duration: 30s
  static const Duration receiveTimeout = Duration(seconds: 30);

  /// Duration: 30s
  static const Duration sendTimeout = Duration(seconds: 30);

  // * || Paths
  static const String sourcesPath = 'sources';
}

class PreferencesKeys {
  const PreferencesKeys._();

  static const String box = 'preferences';

  static const String locale = 'locale';
  static const String themeMode = 'theme_mode';

  static const String initialLocation = 'initial_location';
  static const String discoverSelectedSource = 'discover_selected_source';
}
