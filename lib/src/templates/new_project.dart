import 'dart:io';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import 'package:ngdart/util/conversion.dart';
import '../../constants.dart';

part 'new_project.g.dart';

Future<void> CreateNewProject(ArgResults argResults, String name) async {
  var data = _data;
  for (var i = 0; i < data.length; i += 3) {
    final path = name + '/' + data[i];
    final type = data[i + 1];
    final raw = data[i + 2].replaceAll(whiteSpace, '');

    // print('$name/${path.substring(0, path.length - p.basename(path).length)}');

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
