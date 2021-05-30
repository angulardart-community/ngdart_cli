import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

class CreateProjectCommand extends Command {
  

  @override
  // TODO: implement description
  String get description => 'Create a new AngularDart project.';

  @override
  String get name => 'create';
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