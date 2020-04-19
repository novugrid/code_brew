import 'package:code_brew_example/ui/HomeScreen.dart';
import 'package:code_brew_example/ui/UIRoutes.dart';
import 'package:code_brew_example/ui/features/ImagesExamples.dart';
import 'package:code_brew_example/ui/features/buttons/ButtonsExampleScreen.dart';
import 'package:code_brew_example/ui/features/forms/FormsWidgets.dart';
import 'package:flutter/material.dart';
import 'package:code_brew/code_brew.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CodeBrewTheme.purple(),
//      home: HomeScreen(),
      initialRoute: '/home',
      routes: {
        UIRoutes.home: (context) => HomeScreen(),
        UIRoutes.formsWidgetScreen: (context) => FormsWidgetScreen(),
        UIRoutes.imagesWidgetScreen: (context) => ImagesExamples(),
        UIRoutes.buttonWidgetScreen: (context) => ButtonsExampleScreen(),
      },
    );
  }
}
