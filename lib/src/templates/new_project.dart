import 'dart:io';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import 'package:ngdart/util/conversion.dart';
import '../../constants.dart';

part 'new_project.g.dart';

Future<void> CreateNewProject(ArgResults argResults, String name) async {
  for (var i = 0; i < _data.length; i += 3) {
    final path = name + '/' + _data[i];
    final type = _data[i + 1];
    final raw = _data[i + 2].replaceAll(whiteSpace, '');

    final targetDir =
        Directory(path.substring(0, path.length - p.basename(path).length));
    if (!(await targetDir.exists())) {
      await targetDir.create(recursive: true);
    }

    if (type == 'text') {
      final decoded = Utf8Decoder().convert(base64.decode(raw));
      await File(path)
          .writeAsString(substituteVars(decoded, {'projectName': name}));
    } else {
      final decoded = base64.decode(raw);
      await File(path).writeAsBytes(decoded);
    }
  }
}
