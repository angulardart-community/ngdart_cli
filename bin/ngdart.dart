import 'package:ngdart/ngdart_command_runner.dart';
import 'package:ngdart/util/logger.dart';

void main(List<String> args) async {
  // args = ['serve', '-h'];

  var runner = NgdartCommandRunner();
  CliLogger.initLogger();

  await runner.run(args);
}
