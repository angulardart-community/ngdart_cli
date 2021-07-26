import 'dart:io';

import 'package:io/ansi.dart';
import 'package:logging/logging.dart';

class CliLogger {
  static bool verbose = false;

  static bool canUseColor = true;

  /// Initialize logger
  static void initLogger() {
    canUseColor = stdout.supportsAnsiEscapes;
    Logger.root.onRecord.listen((record) {
			printLog(record);
    });
  }

  static void setVerbosity(bool _verbose) {
		verbose = _verbose;
    if (_verbose) {
      Logger.root.level = Level.ALL;
    } else {
      Logger.root.level = Level.INFO;
    }
  }

  static void printLog(LogRecord record) {
    final level = record.level;
    var buffer = StringBuffer();

    var formattedLevel;
    if (verbose) {
      formattedLevel = '[$level: ${record.loggerName}]';
    } else {
      formattedLevel = '[$level]';
    }
    if (canUseColor) {
      AnsiCode color;
      if (level < Level.WARNING) {
        color = cyan;
      } else if (level < Level.SEVERE) {
        color = yellow;
      } else {
        color = red;
      }
      formattedLevel = color.wrap(formattedLevel);
    }

    buffer.write(formattedLevel);

    if (verbose) {
      buffer.writeCharCode(32); // Empty space
      buffer.write(record.time);
    }

    buffer.writeCharCode(32);
    buffer.write(record.message);

    if (record.error != null) {
      buffer.writeCharCode(32);
      buffer.write(record.error);
    }

		stdout.writeln(buffer);
  }
}
