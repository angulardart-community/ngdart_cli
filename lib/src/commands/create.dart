import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import '../templates/new_project.dart';
import '../../util/ansipen.dart';
import '../../util/conversion.dart';
import '../../util/logger.dart';

class CreateCommand extends Command<int> {
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

    final arg = args.first;
    args = args.skip(1).toList();

    if (args.isNotEmpty) {
      throw UsageException('Unexpected argument $args', '');
    }

    return arg;
  }

  CreateCommand() {
    argParser.addFlag(
      'force',
      abbr: 'f',
      negatable: false,
      help:
          'Force generation into the target directory, overwriting files when needed.',
    );
    argParser.addFlag(
      'pub',
      defaultsTo: true,
      help: "Whether to run 'pub get' after the project has been created.",
    );
    argParser.addOption(
      'path',
      abbr: 'p',
      defaultsTo: '.',
      help: 'Specify the location to create the project.',
    );
  }

  @override
  FutureOr<int> run() async {
    // TODO: Add to "verbose" option
    // print('projectName: ${readArg('aha!')}');
    // print('force: ${argResults!['force']}');
    // print('dir: ${argResults?['path']}');
    final projectName =
        normalizeProjectName(readArg('Requires a project name'));
    // var progress = AppLogger.logger.progress('Creating project');
    stdout.writeln('${progressLog}Creating project...');
    await CreateNewProject(argResults!, projectName);
    // progress.finish(showTiming: true);
    AppLogger.success('Created project \"$projectName\"');
    // print(successLog + 'Created project \"$projectName\"');

    if (argResults?['pub'] == true) {
      final progress = AppLogger.logger.progress(
        "\n${progressLog}Running 'pub get' in the project folder",
      );
      await Process.run(
        'pub',
        ['get'],
        runInShell: true,
        workingDirectory: '$projectName/',
      ).onError((error, stackTrace) => throw Exception(error));
      progress.finish(showTiming: true);
      AppLogger.success('Completed!');
    }
    return 0;
  }
}
