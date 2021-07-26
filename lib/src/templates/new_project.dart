import 'dart:io';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import '../constants.dart';

part 'new_project.g.dart';

Future<void> CreateNewProject(ArgResults argResults, String name) async {
	final logger = Logger('create_from_template');
  final projectDirUrl = p.normalize(argResults['path'] + '/' + name);

  if (!argResults['force']) {
    if (await Directory(projectDirUrl).exists()) {
      throw UsageException(
          'Project directory not empty.\n\nCreate a new project '
              'directory, or use --force to force generation into the target directory.',
          '');
    }
  }

  for (var i = 0; i < _data.length; i += 3) {
    final path = p.normalize(projectDirUrl + '/' + _data[i]);
    final type = _data[i + 1];
    final raw = _data[i + 2].replaceAll(whiteSpace, '');

    // Creates the directory if it doesn't exist
    final targetDir = Directory(p.dirname(path));
    if (!(await targetDir.exists())) {
      await targetDir.create(recursive: true);
    }

    // Treat text files (.dart) and binary files (.png) differently
    if (type == 'text') {
      final decoded = Utf8Decoder().convert(base64.decode(raw));
      await File(path)
          .writeAsString(substituteVars(decoded, {'projectName': name}));
    } else {
      final decoded = base64.decode(raw);
      await File(path).writeAsBytes(decoded);
    }
		logger.fine('Created file at $path');
  }
}

String substituteVars(String str, Map<String, String> vars) {
  if (vars.keys.any((element) => element.contains(nonValidSubstituteRegExp))) {
    throw ArgumentError('vars.keys can only contain letters.');
  }

  return str.replaceAllMapped(substituteRegExp, (match) {
    final item = vars[match[1]];

    if (item == null) {
      return match[0];
    } else {
      return item;
    }
  });
}