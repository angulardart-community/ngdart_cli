import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'constants.dart';
import 'src/commands/create.dart';
import 'src/commands/clean.dart';

Future<int?> run(List<String> args) => NgdartCommandRunner().run(args);

class NgdartCommandRunner extends CommandRunner<int> {
  NgdartCommandRunner() : super(appName, 'A command-line tool for creating and managing AngularDart apps.') {
    argParser.addFlag('version',
        negatable: false, help: 'Prints the version of ngdart.');
    addCommand(CreateCommand());
    addCommand(CleanCommand());
  }

  @override
  Future<int> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] as bool) {
      print(packageVersion);
      return 0;
    }

    // In the case of `help`, `null` is returned. Treat that as success.
    return await super.runCommand(topLevelResults) ?? 0;
  }
}