import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:ngdart/ngdart_command_runner.dart';
import 'package:ngdart/util/ansipen.dart';

Future<void> main(List<String> args) async {
  final runner = NgdartCommandRunner();

  try {
    await runner.run(args);
  } on UsageException catch (e) {
    stderr.writeln('$errorLog$e');
    exit(64);
  } catch (e) {
    stderr.writeln('$errorLog$e');
    exit(exitCode);
  }
}
