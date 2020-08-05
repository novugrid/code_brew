import 'package:code_brew/code_brew.dart';

class CodeBrewMain {


  init() async {
    await CBSessionManager().init();
  }

}