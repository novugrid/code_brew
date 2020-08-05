import 'package:code_brew/src/helpers/CBNumberHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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

class AmountTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    final formatter = new NumberFormat("#,##0.##", "en_US");
    var amountDouble = CBNumberHelper.amountFieldConvert(newValue.text);


    String formatedAmount = formatter.format(amountDouble);
//    String formatedAmount = CBNumberHelper.formatToCurrency(newValue.text);
    TextEditingValue formattedValue = TextEditingValue(text: formatedAmount, selection: TextSelection.collapsed(offset: formatedAmount.length));
    return formattedValue;

  }
}