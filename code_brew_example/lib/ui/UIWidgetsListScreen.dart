import 'package:flutter/material.dart';

class UIWidgetsListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UIWidgetsListScreenState();
}

class _UIWidgetsListScreenState extends State<UIWidgetsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UI Widgets"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Forms"),
            onTap: (){
            },
          ),

        ],
      ),
    );
  }
}
