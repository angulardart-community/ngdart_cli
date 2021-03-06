import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import '../constants.dart';
import '../util/conversion.dart';
import '../util/logger.dart';

part 'new_project.g.dart';

Future<void> createNewProject(ArgResults argResults, String name) async {
  final projectDirUrl = p.normalize('${argResults['path'] as String}/$name');

  if (!(argResults['force'] as bool)) {
    if (await Directory(projectDirUrl).exists()) {
      throw Exception(
        '''
Project directory not empty.

Create a new project directory, or use --force to force generation into the target directory.''',
      );
    }
  }

  for (var i = 0; i < _data.length; i += 3) {
    final path = p.normalize('$projectDirUrl/${_data[i]}');
    final type = _data[i + 1];
    final raw = _data[i + 2].replaceAll(whiteSpace, '');

    // Creates the directory if it doesn't exist
    final targetDir = Directory(p.dirname(path));
    if (!(await targetDir.exists())) {
      await targetDir.create(recursive: true);
    }

    // Treat text files (.dart) and binary files (.png) differently
    if (type == 'text') {
      final decoded = const Utf8Decoder().convert(base64.decode(raw));
      await File(path)
          .writeAsString(substituteVars(decoded, {'projectName': name}));
    } else {
      final decoded = base64.decode(raw);
      await File(path).writeAsBytes(decoded);
    }
    trace('created file at $path');
  }
}
