import 'dart:developer' as developer;

class AppLogger {
  static void debug(String message) {
    developer.log(
      message,
      level: 400, // 400 = fine level in dart:developer
    );
  }

  static void info(String message) {
    developer.log(
      message,
      level: 800, // 800 = info level
    );
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'ERROR',
      level: 1000, // 1000 = severe level
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void warning(String message) {
    developer.log(
      message,
      level: 900, // 900 = warning level
    );
  }
}
