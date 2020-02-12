import 'package:flutter/material.dart';
import 'package:code_brew/code_brew.dart';

class FormsWidgetScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _FormsWidgetsScreenState();

}

class _FormsWidgetsScreenState extends State<FormsWidgetScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          child: Column(
            children: <Widget>[

               UIPasswordField(),

            ],
          ),
        ),
      ),
    );
  }

}