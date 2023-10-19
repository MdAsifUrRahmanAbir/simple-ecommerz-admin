
import 'package:flutter/material.dart';

///* ANSI Color Code
class _Font{
  ///* Text Colors
  String blackColor = '\u001b[30m';
  String redColor = '\u001b[31m';
  String greenColor = '\u001b[32m';
  String yellowColor = '\u001b[33m';
  String orangeColor = '\u001b[38;5;208m';
  String blueColor = '\u001b[34m';
  String magentaColor = '\u001b[35m';
  String cyanColor = '\u001b[36m';
  String whiteColor = '\u001b[37m';
  String resetColor = '\u001b[0m';
}

class _BG{
  ///* Text Background colors
  String blackBgColor = '\u001b[40m';
  String redBgColor = '\u001b[41m';
  String greenBgColor = '\u001b[42m';
  String yellowBgColor = '\u001b[43m';
  String blueBgColor = '\u001b[44m';
  String magentaBgColor = '\u001b[45m';
  String cyanBgColor = '\u001b[46m';
  String whiteBgColor = '\u001b[47m';
}


class TextColor{
  static final font = _Font();
  static final bg = _BG();
}

extension TextColorConsol on String{
  get greenConsole => debugPrint("${TextColor.font.greenColor} $this ${TextColor.font.resetColor}");

  get redConsole => debugPrint("${TextColor.font.redColor} $this ${TextColor.font.resetColor}");

  get yellowConsole => debugPrint("${TextColor.font.yellowColor} $this ${TextColor.font.resetColor}");

  get bgRedConsole => debugPrint("${TextColor.bg.redBgColor} $this ${TextColor.font.resetColor}");

  get bgGreenConsole => debugPrint("${TextColor.bg.greenBgColor} $this ${TextColor.font.resetColor}");

  get bgYellowConsole => debugPrint("${TextColor.bg.yellowBgColor} $this ${TextColor.font.resetColor}");

  void customConsole({required String clr}){
    return debugPrint("$clr $this ${TextColor.font.resetColor}");
  }
}