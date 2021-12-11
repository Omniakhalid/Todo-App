import 'package:flutter/material.dart';

class myThemeData{
  static const Color sec_color = Color.fromRGBO(222, 181, 2, 1.0);
  static final ThemeData light_theme = ThemeData(
      primaryColor: Color.fromRGBO(24, 70, 155, 1.0),
      scaffoldBackgroundColor:Color.fromRGBO(252, 252, 255, 0.8784313725490196),
      canvasColor: Colors.white,
      brightness: Brightness.light,
  );

  static final ThemeData dark_theme = ThemeData(
      primaryColor: Color.fromRGBO(93, 155, 235, 1.0),
      scaffoldBackgroundColor: Color(0xFF060E1E),
      canvasColor: Color(0xFF141922),
      brightness: Brightness.dark,
  );
}