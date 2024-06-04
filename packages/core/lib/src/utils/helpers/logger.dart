import 'package:logger/logger.dart';

final class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      stackTraceBeginIndex: 1,
    ),
    level: Level.debug,
  );

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(
      message,
      error: error,
      stackTrace: stackTrace ?? StackTrace.current,
    );
  }
}
