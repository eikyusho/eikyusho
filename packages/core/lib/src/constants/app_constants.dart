final class AppConstants {
  const AppConstants._();

  // * || App
  static const String appName = 'Eikyusho';
  static const String appId = 'com.eikyusho.app';

  // * || API
  static const String apiBaseUrl =
      'https://raw.githubusercontent.com/noahbpaiva/eikyusho-extensions-mock/main';
  static const String extensionsList = '$apiBaseUrl/webnovel_data.json';

  // * || Timeouts
  /// Duration: 30s
  static const Duration connectTimeout = Duration(seconds: 30);

  /// Duration: 30s
  static const Duration receiveTimeout = Duration(seconds: 30);

  /// Duration: 30s
  static const Duration sendTimeout = Duration(seconds: 30);
}
