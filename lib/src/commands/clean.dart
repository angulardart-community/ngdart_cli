import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import 'package:ngdart/util/ansipen.dart';

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
        print(progressLog + 'Deleting build/ ...');
        await buildDir.delete(recursive: true);
      }
      if ((await toolDir.exists()))
      {
        print(progressLog + 'Deleting .dart_tools/ ...');
        await toolDir.delete(recursive: true);
      }
    } catch (e) {
      throw Exception(e);
    }
    print(successLog + 'All clean!');

    return 0;
  }
}