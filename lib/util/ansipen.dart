import 'package:ansicolor/ansicolor.dart';

AnsiPen errorPen = AnsiPen()..rgb(r: 1, g: 0, b: 0)..black();
AnsiPen errorTriangle = AnsiPen()..red();
AnsiPen progressPen = AnsiPen()..black()..cyan();
AnsiPen successPen = AnsiPen()..black()..green();

var errorHeader = errorPen(' 🕱 ') + errorTriangle('');