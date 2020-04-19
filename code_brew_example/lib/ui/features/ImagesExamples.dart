import 'package:flutter/material.dart';
import 'package:code_brew/code_brew.dart';

class ImagesExamples extends StatefulWidget {
  @override
  _ImagesExamplesState createState() => _ImagesExamplesState();
}

class _ImagesExamplesState extends State<ImagesExamples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: UIProfileImage(),
            ),
          ],
        ),
      ),
    );
  }
}
