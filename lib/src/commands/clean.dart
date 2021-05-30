import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

class CleanCommand extends Command<int> {
  @override
  String get description => 'Delete the build/ and .dart_tool/ directories.';

  @override
  String get name => 'clean';
  
  @override
  String get invocation => 'ngdart clean';

  @override
  FutureOr<int> run() async {
    var buildDir = Directory('build');
    var toolDir = Directory('.dart_tool');

    try {
      if ((await buildDir.exists())) {
        await buildDir.delete(recursive: true);
      }
      if ((await toolDir.exists()))
      {
        await toolDir.delete(recursive: true);
      }
    } catch (e) {
      throw Exception(e);
    }

    return 0;
  }
}