import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

class CreateProjectCommand extends Command {
  final _argParser = ArgParser(allowTrailingOptions: true);
  ArgParser get argParser => _argParser;

  String readArg(String errorMessage) {
    var args = argResults?.rest;

    if (args == null || args.isEmpty) {
      // Usage is provided by command runner.
      throw UsageException(errorMessage, '');
    }

    // TODO: I am skeptic about the usefulness of the following code
    var arg = args.first;
    args = args.skip(1).toList();

    if (args.isEmpty) {
      throw UsageException('Unexpected argument $args', '');
    }

    return arg;
  }

  @override
  // TODO: implement description
  String get description => throw UnimplementedError();

  @override
  String get name => 'create';

  // /// Reads argument for current command and create an EntityName.
  // EntityName readArgAsEntityName(String errorMessage) =>
  //     getEntityName(readArg(errorMessage));

  // EntityName getEntityName(String entity) {
  //   EntityName entityName;

  //   try {
  //     entityName = new EntityName(entity);
  //   } on ArgumentError catch (error) {
  //     throw new UsageException(error.message, '');
  //   }

  //   return entityName;
  // }
}
