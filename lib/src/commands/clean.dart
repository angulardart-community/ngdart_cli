import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';

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
    var pubspec = File('pubspec.yaml');
    var logger = Logger.standard(ansi: Ansi(true));

    try {
      if (!(await pubspec.exists())) {
        throw 'pubspec.yaml not found!';
      }
      if ((await buildDir.exists())) {
        var progress = logger.progress(progressLog + 'Deleting build/ ...');
        await buildDir.delete(recursive: true);
        progress.finish(showTiming: true);
      }
      if ((await toolDir.exists()))
      {
        var progress = logger.progress(progressLog + 'Deleting .dart_tools/ ...');
        await toolDir.delete(recursive: true);
        progress.finish(showTiming: true);
      }
    } catch (e) {
      throw Exception(e);
    }
    print(successLog + 'All clean!');

    return 0;
  }
}