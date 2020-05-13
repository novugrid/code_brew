import 'package:flutter/material.dart';
import 'package:code_brew/widgets.dart';

class GridExampleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GridExampleScreen();
}

class _GridExampleScreen extends State<GridExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CB Grid Example"),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 30,
                color: Colors.pink,
              ),
              Container(
                height: 100,
                child: UIGridView(
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Container(
                        child: Text("data"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
