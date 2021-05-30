export './src/version.dart';

String appName = 'ngdart';

final substituteRegExp = RegExp(r'__([a-zA-Z]+)__');
final nonValidSubstituteRegExp = RegExp('[^a-zA-Z]');
final whiteSpace = RegExp(r'\s+');