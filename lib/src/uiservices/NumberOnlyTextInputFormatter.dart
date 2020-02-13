import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberOnlyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // var numPattern = RegExp(r"[0-9]");
    var numericNoSymbolsRegExp = RegExp(r"^[0-9]+$");
    if (numericNoSymbolsRegExp.hasMatch(newValue.text)) {
      return newValue;
    }
    // else its not a number
    if (newValue.text.isEmpty) {
      return newValue;
    } else return oldValue;
  }
}