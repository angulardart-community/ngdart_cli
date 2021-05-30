import 'dart:io';
import 'dart:convert';

import 'package:path/path.dart' as p;

import 'package:ngdart/src/templates/new_project.dart';
import 'package:ngdart/util/conversion.dart';

final _whiteSpace = RegExp(r'\s+');

void main(List<String> args) async {
  // try {
  //   exitCode = (await run(args))!;
  // } catch (e) {

  // }
  final data = newProjectTemplateFiles();
  for (var i = 0; i < data.length; i += 3) {
    final path = data[i];
    final type = data[i + 1];
    final raw = data[i + 2].replaceAll(_whiteSpace, '');

    print('bruh/${path.substring(0, path.length - p.basename(path).length)}');

    final targetDir = Directory(
        'bruh/${path.substring(0, path.length - p.basename(path).length)}');
    if (!(await targetDir.exists())) {
      await targetDir.create(recursive: true);
    }

    if (type == 'text') {
      final decoded = Utf8Decoder().convert(base64.decode(raw));
      await File('bruh/$path')
          .writeAsString(substituteVars(decoded, {'projectName': 'test'}));
    } else {
      final decoded = base64.decode(raw);
      await File('bruh/$path').writeAsBytes(decoded);
    }
  }
}
