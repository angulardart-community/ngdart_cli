import 'dart:io';

import 'package:ngdart/ngdart_command_runner.dart';

void main(List<String> args) async {
  try {
    exitCode = (await run(args))!;
  } catch (e) {
    
  }
}
