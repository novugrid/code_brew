import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CBUtility {
  static String extractErrorMessageFromResponse(Response response) {
    String message = "";
    try {
      if (response?.data != null && response.data["message"] != null) {
        message = response.data["message"];
      } else {
        message = response?.statusMessage ??
            "Oops an error occurred, "
                "couldnt connect to the server, please check your network connection and try again";
      }
    } catch (error, stackTrace) {
      message = response?.statusMessage ?? error.toString();
    }
    return message;
  }

  ///For getting the widgetrelative position on a widget tree
  ///returns [RelativeRect] the position of the widget
  ///
  static RelativeRect getWidgetPositionOnScreen(BuildContext context, GlobalKey widgetKey)
  {
    final RenderBox popUpRenderBox = widgetKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        popUpRenderBox.localToGlobal(popUpRenderBox.size.bottomRight(Offset.zero), ancestor: overlay),
        popUpRenderBox.localToGlobal(popUpRenderBox.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }

  // TODO: Please Remove to CB DateHelper
  static String formatDate(DateTime dateTime) {
    return DateFormat("EEE, d MMM yyyy").add_jm().format(dateTime);
  }

}
