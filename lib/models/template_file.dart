import 'dart:convert' show utf8;

import 'package:ngdart/util/conversion.dart';
import 'file_contents.dart';

class TemplateFile {
  final String path;
  final String? content;

  List<int>? _binaryData;

  TemplateFile(this.path, this.content);

  TemplateFile.fromBinary(this.path, this._binaryData) : content = null;

  FileContents runSubstitution(Map<String, String> parameters) {
    if (path == 'pubspec.yaml' && parameters['author'] == '<your name>') {
      parameters = Map.from(parameters);
      parameters['author'] = 'Your Name';
    }

    final newPath = substituteVars(path, parameters);
    final newContents = _createContent(parameters);

    return FileContents(newPath, newContents);
  }

  bool get isBinary => _binaryData != null;

  List<int> _createContent(Map<String, String> vars) {
    if (isBinary) {
      return _binaryData!;
    } else {
      return utf8.encode(substituteVars(content!, vars));
    }
  }
}