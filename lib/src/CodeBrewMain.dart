import 'package:code_brew/code_brew.dart';
import 'package:flutter/material.dart';

class CodeBrewMain {


  init() async {
    await CBSessionManager().init();
  }

}