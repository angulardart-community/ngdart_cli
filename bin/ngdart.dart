import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:ngdart/ngdart_command_runner.dart';
import 'package:ngdart/util/ansipen.dart';

void main(List<String> args) async {
  var runner = NgdartCommandRunner();

  try {
    await runner.run(args);
  } on UsageException catch (e) {
    print(errorLog + '$e');
    print(runner.usage);
    exit(64);
  } catch (e) {
    print(errorLog + '$e');
    exit(exitCode);
  }
}
