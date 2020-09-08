import 'package:flutter/material.dart';

///
/// project: de_wallet_vendor
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 29/03/2020
mixin UiKits {
  static const String Avenir = "Avenir";
  static const String ALight = "ALight";
  static const String ABook = "ABook";
  static const String ARoman = "ARoman";
  static const String AMedium = "AMedium";
  static const String AHeavy = "AHeavy";
  static const String ABlack = "ABlack";

  ValueNotifier<bool> preogressNotifier = ValueNotifier(false);

  Widget Height(double h) { 
    return new SizedBox(height: h);
  }

  Widget Width(double w) {
    return new SizedBox(width: w);
  }

  Widget ExpandableText(String text,
      {TextStyle textStyle,
      int maxLines = 2,
      TextAlign alignment = TextAlign.start}) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(
          "$text",
          style: textStyle,
          maxLines: maxLines,
          textAlign: alignment,
        ))
      ],
    );
  }
}
