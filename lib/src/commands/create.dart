import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:charcode/charcode.dart';
import 'package:io/ansi.dart';
import 'package:logging/logging.dart';
import 'package:interact/interact.dart';

import '../templates/new_project.dart';
import '../../util/logger.dart';
import '../../util/conversion.dart';

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
  String readArg(String errorMessage) {
    var args = argResults?.rest;

    if (args == null || args.isEmpty) {
      // Usage is provided by command runner.
      throw UsageException(errorMessage, '');
    }

    var arg = args.first;
    args = args.skip(1).toList();

    if (args.isNotEmpty) {
      throw UsageException('Unexpected argument $args', '');
    }

    return arg;
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
    var projectName = normalizeProjectName(readArg('Requires a project name'));

    if (CliLogger.verbose == true) {
      logger.info('Creating project...');
      await CreateNewProject(argResults!, projectName);
      logger.info('Created project \"$projectName\"');
    } else {
      final create = Spinner(
        icon: green.wrap('[${String.fromCharCode($radic)}]')!,
        leftPrompt: (done) => '',
        rightPrompt: (done) =>
            done ? 'Created project \"$projectName\"' : 'Creating project...',
      ).interact();
      await CreateNewProject(argResults!, projectName);
      await Future.delayed(Duration(seconds: 1));
      create.done();
    }

    if (argResults!['pub'] == true) {
      final pub = Spinner(
        icon: green.wrap('[${String.fromCharCode($radic)}]')!,
        leftPrompt: (done) => '',
        rightPrompt: (done) => done
            ? 'Fetched dependencies!'
            : 'Running \'pub get\' in the project folder...',
      ).interact();
      var result = await Process.run(
        'pub',
        ['get'],
        runInShell: true,
        workingDirectory: '$projectName/',
      );
      if (result.stderr != null && result.stderr.toString().isNotEmpty) {
        throw Exception(result.stderr);
      }
      pub.done();
    }

    return 0;
  }
}
