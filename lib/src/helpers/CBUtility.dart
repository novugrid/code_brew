import 'package:dio/dio.dart';

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
}
