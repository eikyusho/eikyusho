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

  // * || Keys
  static const String discoverSelectedSourceKey = 'discoverSelectedSource';
}
