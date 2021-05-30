import 'package:ansicolor/ansicolor.dart';

AnsiPen errorPen = AnsiPen()..black()..xterm(160, bg: true);
AnsiPen errorTriangle = AnsiPen()..xterm(160);
AnsiPen progressPen = AnsiPen()..black()..xterm(045, bg: true);
AnsiPen progressTriangle = AnsiPen()..xterm(045);
AnsiPen successPen = AnsiPen()..black()..xterm(040, bg: true);
AnsiPen successTriangle = AnsiPen()..xterm(040);

var errorLog = errorPen(' 🕱 ') + errorTriangle('') + ' ';
var progressLog = progressPen(' ⮞ ') + progressTriangle('') + ' ';
var successLog = successPen(' 🗸 ') + successTriangle('') + ' ';