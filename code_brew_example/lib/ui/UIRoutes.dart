import 'package:flutter/cupertino.dart';

class UIRoutes {

  static String home = "/home";
  static String formsWidgetScreen = "/formsScreen";
  static String imagesWidgetScreen = "/imagesScreen";
  static String buttonWidgetScreen = "buttons";

  navigator(BuildContext context) {
    Navigator.of(context).pushNamed("");
  }

  static void navigateToFormsScreen(BuildContext context) {
    Navigator.pushNamed(context, formsWidgetScreen);
  }
  static void navigateToImagesScreen(BuildContext context) {
      Navigator.pushNamed(context, imagesWidgetScreen);
  }
  static void navigateToButtonScreen(BuildContext context) {
      Navigator.pushNamed(context, buttonWidgetScreen);
  }

}