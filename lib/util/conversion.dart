final _substituteRegExp = RegExp(r'__([a-zA-Z]+)__');
final _nonValidSubstituteRegExp = RegExp('[^a-zA-Z]');
final _whiteSpace = RegExp(r'\s+');

/// Convert the name of a project into a legal pub package name.
String normalizeProjectName(String name) {
  name = name.replaceAll('-', '_').replaceAll(' ', '_');

  // Remove any extension (like .dart).
  if (name.contains('.')) {
    name = name.substring(0, name.indexOf('.'));
  }

  return name;
}

String substituteVars(String str, Map<String, String> vars) {
  if (vars.keys.any((element) => element.contains(_nonValidSubstituteRegExp))) {
    throw ArgumentError('vars.keys can only contain letters.');
  }

  return str.replaceAllMapped(_substituteRegExp, (match) {
    final item = vars[match[1]];

    if (item == null) {
      return match[0]!;
    } else {
      return item;
    }
  });
}