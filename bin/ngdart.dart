import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:ngdart/ngdart_command_runner.dart';
import 'package:ngdart/util/ansipen.dart';

void main(List<String> args) async {
  var runner = NgdartCommandRunner();

  try {
    print(errorHeader);
    await runner.run(args);
  } on UsageException catch (e) {
    // print(errorHeader + '$e');
    print(e);
    print(runner.usage);
    exit(64);
  } catch (e) {
    print(e);
    throw exitCode;
  }
}
