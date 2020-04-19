import 'package:flutter/material.dart';
import 'package:code_brew/code_brew.dart';

class ButtonsExampleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ButtonsExampleScreen();
}

class _ButtonsExampleScreen extends State<ButtonsExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buttons"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              UIButton(
                type: UIButtonType.flat,
                onPressed: () {},
                child: Text("Arrow Forward"),
                icon: Icon(Icons.arrow_forward),
                iconAlignment: UIAlignment.right,
              ),
              UIButton(
                type: UIButtonType.flat,
                onPressed: null,
                text: "Backwards",
                icon: Icon(Icons.arrow_back),
                iconAlignment: UIAlignment.left,
              ),
              UIButton(
                type: UIButtonType.raised,
                onPressed: () {},
                text: "Top Now",
                icon: Icon(Icons.arrow_upward),
                iconAlignment: UIAlignment.top,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
