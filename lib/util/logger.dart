import 'package:ansicolor/ansicolor.dart';
import 'package:cli_util/cli_logging.dart';

class AppLogger {
  static bool isVerbose = false;
  static var logger = isVerbose ? Logger.verbose() : Logger.standard();

  static Map<String, AnsiPen> pens = {
    'error': AnsiPen()..xterm(160),
    'info': AnsiPen()..xterm(045),
    'success': AnsiPen()..xterm(040),
  };

  // AnsiPen errorPen = AnsiPen()
  //   ..black()
  //   ..xterm(160, bg: true);
  // AnsiPen errorTriangle = AnsiPen()..xterm(160);
  // AnsiPen progressPen = AnsiPen()
  //   ..black()
  //   ..xterm(045, bg: true);
  // AnsiPen progressTriangle = AnsiPen()..xterm(045);
  // AnsiPen successPen = AnsiPen()
  //   ..black()
  //   ..xterm(040, bg: true);
  // AnsiPen successTriangle = AnsiPen()..xterm(040);

  // Unfortunately these are illegal characters...
  // var errorLog = errorPen(' 🕱 ') + errorTriangle('') + ' ';
  // var progressLog = progressPen(' ⮞ ') + progressTriangle('') + ' ';
  // var successLog = successPen(' 🗸 ') + successTriangle('') + ' ';
  // var errorLog = errorTriangle('[Error] ');
  // var progressLog = progressTriangle('[Info] ');
  // var successLog = successTriangle('[Success] ');

  static void error(String message) {
    logger.stderr('${pens['error']('[ERROR]')} $message');
  }
  static void info(String message) {
    logger.stdout('${pens['info']('[INFO]')} $message');
  }
  static void success(String message) {
    logger.stdout('${pens['success']('[SUCCESS]')} $message');
  }
  static void trace(String message) {
    logger.trace('${pens['info']('[TRACE]')} $message');
  }
}
