import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:io/io.dart';

import 'constants.dart';
import 'util/logger.dart';
import 'src/commands/create.dart';
import 'src/commands/clean.dart';
import 'src/commands/build.dart';
import 'src/commands/serve.dart';

Future<int?> run(List<String> args) => NgdartCommandRunner().run(args).then((value) => value as int?);

class NgdartCommandRunner extends CommandRunner {
  NgdartCommandRunner() : super(appName, 'A command-line tool for creating and managing AngularDart projects.') {
    argParser.addFlag('version', abbr: 'v',
        negatable: false, help: 'Prints the version of ngdart.');
    argParser.addFlag('verbose', negatable: false, help: 'Show additional command output');
    addCommand(CreateCommand());
		addCommand(CleanCommand());
		addCommand(NgBuildCommand());
		addCommand(NgServeCommand());
  }

  @override
  Future<int> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] as bool) {
      print(packageVersion);
      return ExitCode.success.code;
    }
		CliLogger.setVerbosity(topLevelResults['verbose']);
    // In the case of `help`, `null` is returned. Treat that as success.
    return await (super.runCommand(topLevelResults) as FutureOr<int>?) ?? ExitCode.success.code;
  }
}