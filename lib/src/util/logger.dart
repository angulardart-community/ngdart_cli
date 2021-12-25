import 'package:ansicolor/ansicolor.dart';
import 'package:cli_util/cli_logging.dart';

Logger logger = Logger.standard(ansi: Ansi(true));

void error(String message) {
  final AnsiPen pen = AnsiPen()..xterm(160);
  logger.stderr('${pen('[Error]')} $message');
}

void info(String message) {
  final AnsiPen pen = AnsiPen()..xterm(045);
  logger.stdout('${pen('[Info]')} $message');
}

void success(String message) {
  final AnsiPen pen = AnsiPen()..xterm(040);
  logger.stdout('${pen('[Success]')} $message');
}

void trace(String message) {
  final AnsiPen pen = AnsiPen()..xterm(045);
  logger.trace('${pen('[Trace]')} $message');
}
