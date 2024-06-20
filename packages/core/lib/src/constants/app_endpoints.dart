final class AppEndpoints {
  const AppEndpoints._();

  static const String source = 'https://raw.githubusercontent.com/eikyusho';

  // * || API
  static const String baseUrl = '$source/extensions/main';
  static const String extensionsList = '/index.min.json';
  static const String extensionsBinaries = '/bin';
  static const String extensions = '$baseUrl/$extensionsBinaries';
}
