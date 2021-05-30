import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:ngdart/src/templates/new_project.dart';

class CreateCommand extends Command<int> {
  @override
  String get description => 'Create a new project.';

  @override
  String get name => 'create';

  @override
  String get invocation =>
      'ngdart create <project_name> [--path <project/path>] [--force]';

  /// Reads argument for current command.
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
    argParser.addFlag('force', abbr: 'f', negatable: false);
    argParser.addOption('path', abbr: 'p', defaultsTo: '.');
  }

  @override
  FutureOr<int> run() async {
    print('projectName: ${readArg('aha!')}');
    print('force: ${argResults!['force']}');
    await CreateNewProject(argResults!, readArg('bruh no project name'));
    return 1;
  }
}



  // final _argParser = ArgParser(allowTrailingOptions: true);
  // ArgParser get argParser => _argParser;

  // String readArg(String errorMessage) {
  //   var args = argResults?.rest;

  //   if (args == null || args.isEmpty) {
  //     // Usage is provided by command runner.
  //     throw UsageException(errorMessage, '');
  //   }

  //   // TODO: I am skeptic about the usefulness of the following code
  //   var arg = args.first;
  //   args = args.skip(1).toList();

  //   if (args.isEmpty) {
  //     throw UsageException('Unexpected argument $args', '');
  //   }

  //   return arg;
  // }