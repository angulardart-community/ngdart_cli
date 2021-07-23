import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import 'package:ngdart/ngdart_command_runner.dart';
import 'package:ngdart/util/ansipen.dart';

void main(List<String> args) async {
	// args = ['serve', '-h'];

  var runner = NgdartCommandRunner();

  try {
    await runner.run(args);
  } on UsageException catch (e) {
    print(errorLog + '$e');
    exit(64);
  } catch (e) {
    print(errorLog + '$e');
    exit(exitCode);
  }
}
