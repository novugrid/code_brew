import 'package:flutter/material.dart';

class UILoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UILoginScreen();
}

class _UILoginScreen extends State<UILoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField()
        ],
      ),
    );
  }
}
