import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'commands/clean.dart';
import 'commands/create.dart';
import 'constants.dart';
import 'util/logger.dart';

class NgdartCommandRunner extends CommandRunner<int> {
  NgdartCommandRunner()
      : super(appName,
            'A command-line tool for creating and managing AngularDart projects.',) {
    argParser.addFlag('version',
        abbr: 'v', negatable: false, help: 'Prints the version of ngdart.',);
    argParser.addFlag('verbose',
        negatable: false, help: 'Show additional command output',);
    addCommand(CreateCommand());
    addCommand(CleanCommand());
  }

  @override
  Future<int> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] as bool) {
      stdout.writeln(packageVersion);
      return 0;
    }
    AppLogger.isVerbose = topLevelResults['verbose'] as bool;
    // In the case of `help`, `null` is returned. Treat that as success.
    return await super.runCommand(topLevelResults) ?? 0;
  }
}
