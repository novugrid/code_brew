import 'package:flutter/material.dart';

class CodeBrewTheme {
  // factory CodeBrewTheme({Color accentColor}) {}
//  factory CodeBrewTheme() {}

  static TextStyle textFieldStyle = TextStyle();
  static TextStyle defaultText = TextStyle();


  static ThemeData green() {
    return ThemeData(
        primaryColor: Colors.green, accentColor: Colors.deepOrangeAccent);
  }

  static ThemeData purple() {
    return ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        primaryColorDark: Colors.indigo.shade700,
        accentColor: Colors.indigoAccent);
  }

  static ThemeData crawlDark()
  {

  }


}
