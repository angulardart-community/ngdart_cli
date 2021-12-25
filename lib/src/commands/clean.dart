import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';

import '../util/logger.dart';

class CleanCommand extends Command<int> {
  @override
  String get description => 'Delete the build/ and .dart_tool/ directories.';

  @override
  String get name => 'clean';

  @override
  String get invocation => 'ngdart clean';

  @override
  FutureOr<int> run() async {
    final buildDir = Directory('build');
    final toolDir = Directory('.dart_tool');
    final packages = File('.packages');
    final pubspec = File('pubspec.yaml');
    final logger = Logger.standard(ansi: Ansi(true));

    if (!(await pubspec.exists())) {
      throw Exception('pubspec.yaml not found!');
    }
    if (await buildDir.exists()) {
      final progress = logger.progress('Deleting build');
      await buildDir.delete(recursive: true);
      progress.finish(showTiming: true);
    }
    if (await toolDir.exists()) {
      final progress = logger.progress('Deleting .dart_tools');
      await toolDir.delete(recursive: true);
      progress.finish(showTiming: true);
    }
    if (await packages.exists()) {
      final progress = logger.progress('Deleting .packages');
      await packages.delete();
      progress.finish(showTiming: true);
    }
    success('All clean!');

    return 0;
  }
}
