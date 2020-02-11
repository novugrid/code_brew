import 'package:code_brew_example/ui/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:code_brew/code_brew.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CodeBrewTheme.green(),
      home: HomeScreen(),
    );
  }
}
