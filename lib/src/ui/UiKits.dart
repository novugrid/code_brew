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

  //Large screen is any screen whose width is more than 1200 pixels
  bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }
  //Small screen is any screen whose width is less than 800 pixels
  bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }
  //Medium screen is any screen whose width is less than 1200 pixels,
  //and more than 800 pixels
  bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.width < 1200;
  }


}
