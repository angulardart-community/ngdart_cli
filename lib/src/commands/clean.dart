import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:charcode/charcode.dart';
import 'package:io/ansi.dart';
import 'package:interact/interact.dart';
import 'package:io/io.dart';
import 'package:logging/logging.dart';

class CleanCommand extends Command<int> {
  final logger = Logger('clean');

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
    var packages = File('.packages');
    var pubspec = File('pubspec.yaml');

    if (!(await pubspec.exists())) {
      logger.severe('pubspec.yaml not found!');
      return ExitCode.noInput.code;
    } else {
      try {
        if (await buildDir.exists()) {
          final build = Spinner(
            icon: green.wrap('[${String.fromCharCode($radic)}]'),
            rightPrompt: (done) => 'Deleting build...',
          ).interact();
          await buildDir.delete(recursive: true);
          build.done();
        }
        if (await toolDir.exists()) {
          final tool = Spinner(
            icon: green.wrap('[${String.fromCharCode($radic)}]'),
            rightPrompt: (done) => 'Deleting .dart_tools...',
          ).interact();
          await toolDir.delete(recursive: true);
          tool.done();
        }
        if (await packages.exists()) {
          final _packages = Spinner(
            icon: green.wrap('[${String.fromCharCode($radic)}]'),
            rightPrompt: (done) => 'Deleting .packages...',
          ).interact();
          await packages.delete();
          _packages.done();
        }
      } on Exception catch (e) {
				logger.severe(e);
				return ExitCode.ioError.code;
      }

      logger.info('All clean!');

			return ExitCode.success.code;
    }
  }
}
