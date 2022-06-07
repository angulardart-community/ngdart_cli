import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:ngdart_cli/src/ngdart_command_runner.dart';
import 'package:ngdart_cli/src/util/logger.dart';

Future<void> main(List<String> args) async {
  final runner = NgdartCommandRunner();

  try {
    await runner.run(args);
  } on UsageException catch (e) {
    error('$e');
    exit(64);
  } catch (e) {
    error('$e');
    exit(1);
  }
}
