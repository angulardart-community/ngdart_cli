import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

const List<String> _allowedDotFiles = <String>['.gitignore'];
final RegExp _binaryFileTypes = RegExp(
    r'\.(jpe?g|png|gif|ico|svg|ttf|eot|woff|woff2)$',
    caseSensitive: false);

Builder buildTemplate([BuilderOptions? options]) => _TemplateBuilder();

class _TemplateBuilder implements Builder {
  @override
  Future build(BuildStep buildStep) async {
    // final topFolder = AssetId(buildStep.inputId.package, 'template/');

    final name = p.basenameWithoutExtension(buildStep.inputId.path);
    final targetFile =
        AssetId(buildStep.inputId.package, 'lib/src/templates/$name.g.dart');

    final filteredAssets =
        await buildStep.findAssets(Glob('templates/$name/**')).where((asset) {
      // This function filters out some assets(files) that we don't need to include in our template
      final rootSegment = asset.pathSegments[2];

      if (rootSegment == 'build' || rootSegment == 'pubspec.lock') {
        // If it contains the build folder or pubspec.lock
        return false;
      } else if (_allowedDotFiles.contains(rootSegment)) {
        // If it's a .gitignore file
        return false;
      } else {
        return !rootSegment.startsWith('.');
      }
    }).toList()
          ..sort();

    final items = await _getLines(filteredAssets, buildStep).map((item) {
      if (item.contains('\n')) {
        return "'''\n$item'''";
      }
      return "'$item'";
    }).join(',');

    await buildStep.writeAsString(
        targetFile, '''
// Generated code. Do not modify by hand (unless you know what you're doing).

part of '$name.dart';

const _data = <String>[$items];
''');
  }

  @override
  final buildExtensions = const {
    '.dart': ['.g.dart']
    // r'$template$': ['src/template/hey.dart']
  };
}

// Copied from stagehand
Stream<String> _getLines(List<AssetId> ids, AssetReader reader) async* {
  for (var id in ids) {
    yield p.url.joinAll(id.pathSegments.skip(2));
    yield _binaryFileTypes.hasMatch(p.basename(id.path)) ? 'binary' : 'text';
    yield _base64encode(await reader.readAsBytes(id));
  }
}

// Copied from stagehand
String _base64encode(List<int> bytes) {
  final encoded = base64.encode(bytes);

//
// Logic to cut lines into 76-character chunks
// – makes for prettier source code
//
  final lines = <String>[];
  var index = 0;

  while (index < encoded.length) {
    final line = encoded.substring(index, math.min(index + 76, encoded.length));
    lines.add(line);
    index += line.length;
  }

  return lines.join('\r\n');
}
