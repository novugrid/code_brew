import 'package:flutter/services.dart';
import 'dart:math' as math;

class PinTextInputFormatter extends TextInputFormatter {
  PinTextInputFormatter({this.maxLength, this.onNewCharacterEntered})
      : assert(maxLength == null || maxLength == -1 || maxLength > 0);

  final int maxLength;
  final Function(String value) onNewCharacterEntered;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // var numPattern = RegExp(r"[0-9]");
    var numericNoSymbolsRegExp = RegExp(r"^[0-9]+$");
    var emptyString = RegExp(r"^\s*$");

    if (oldValue.text.isEmpty && newValue.text.trim().isEmpty) {
      return oldValue;
    }

    if (numericNoSymbolsRegExp.hasMatch(newValue.text) ||
        emptyString.hasMatch(newValue.text)) {
      return limiting(oldValue, newValue);
      // return newValue;
    }
    // else its not a number
    return oldValue;
  }

  TextEditingValue limiting(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (maxLength != null &&
        maxLength > 0 &&
        newValue.text.runes.length > maxLength) {
      this.onNewCharacterEntered(
          newValue.text); // notify use that a new character has been entered

      final TextSelection newSelection = newValue.selection.copyWith(
        baseOffset: math.min(newValue.selection.start, maxLength),
        extentOffset: math.min(newValue.selection.end, maxLength),
      );
      // This does not count grapheme clusters (i.e. characters visible to the user),
      // it counts Unicode runes, which leaves out a number of useful possible
      // characters (like many emoji), so this will be inaccurate in the
      // presence of those characters. The Dart lang bug
      // https://github.com/dart-lang/sdk/issues/28404 has been filed to
      // address this in Dart.
      // TODO(gspencer): convert this to count actual characters when Dart
      // supports that.
      final RuneIterator iterator = RuneIterator(newValue.text);
      if (iterator.moveNext())
        for (int count = 0; count < maxLength; ++count)
          if (!iterator.moveNext()) break;
      final String truncated = newValue.text.substring(0, iterator.rawIndex);
      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
