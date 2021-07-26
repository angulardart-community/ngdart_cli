import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:charcode/charcode.dart';
import 'package:io/ansi.dart';
import 'package:io/io.dart';
import 'package:logging/logging.dart';
import 'package:interact/interact.dart';

import '../templates/new_project.dart';
import '../util/logger.dart';

class CreateCommand extends Command<int> {
  final logger = Logger('create');

  @override
  String get description => 'Create a new project.';

  @override
  String get name => 'create';

  @override
  String get invocation =>
      'ngdart create <project_name> [--path <project/path>] [--force]';

  // Reads argument for current command.
  String readArg() {
    var args = argResults?.rest;

    if (args == null || args.isEmpty) {
      // Usage is provided by command runner.
      throw UsageException('You must provide a project name.', '');
    }

    var arg = args.first;
    args = args.skip(1).toList();

    if (args.isNotEmpty) {
      throw UsageException('Unexpected argument $args', '');
    }

    return arg;
  }

  bool isValidProjectName(String name) {
    if (name.contains(RegExp(r'[a-z0-9_]'))) {
      return true;
    } else {
      return false;
    }
  }

  CreateCommand() {
    argParser.addFlag('force',
        abbr: 'f',
        negatable: false,
        help:
            'Force generation into the target directory, overwriting files when needed.');
    argParser.addFlag('pub',
        negatable: true,
        defaultsTo: true,
        help: 'Whether to run \'pub get\' after the project has been created.');
    argParser.addOption('path',
        abbr: 'p',
        defaultsTo: '.',
        help: 'Specify the location to create the project.');
  }

  @override
  FutureOr<int> run() async {
    var projectName = argResults.rest.first;
    if (!isValidProjectName(projectName)) {
      logger.severe('\"$projectName\" is not a valid Dart project name.\n');
      stdout.writeln(
          'See https://dart.dev/tools/pub/pubspec#name for more information.');
      return ExitCode.data.code;
    }

    if (CliLogger.verbose == true) {
      logger.info('Creating project...');
      await CreateNewProject(argResults, projectName);
      logger.info('Created project \"$projectName\"');
    } else {
      final create = Spinner(
        icon: green.wrap('[${String.fromCharCode($radic)}]'),
        leftPrompt: (done) => '',
        rightPrompt: (done) =>
            done ? 'Created project \"$projectName\"' : 'Creating project...',
      ).interact();
      await CreateNewProject(argResults, projectName);
      await Future.delayed(Duration(seconds: 1));
      create.done();
    }

    try {
      if (argResults['pub'] == true) {
        final pub = Spinner(
          icon: green.wrap('[${String.fromCharCode($radic)}]'),
          leftPrompt: (done) => '',
          rightPrompt: (done) => done
              ? 'Fetched dependencies!'
              : 'Running \"pub get\" in the project folder...',
        ).interact();
        var result = await Process.run(
          'pub',
          ['get'],
          runInShell: true,
          workingDirectory: '$projectName/',
        );
        if (result.stderr != null && result.stderr.toString().isNotEmpty) {
          logger.severe(result.stderr);
          return ExitCode.ioError.code;
        }
        pub.done();
      }
    } on Exception catch (e) {
      logger.severe(e);
      return 1;
    }

    return ExitCode.success.code;
  }
}
