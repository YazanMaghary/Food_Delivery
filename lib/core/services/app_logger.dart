import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();
  static final logger = Logger(
    printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5, lineLength: 50),
    level: kDebugMode ? Level.debug : Level.off,
  );
}
