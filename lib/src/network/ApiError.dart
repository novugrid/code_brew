import 'package:code_brew/src/network/models/ApiErrorModel.dart';
import 'package:dio/dio.dart';

typedef ApiErrorCallback = Function(CBApiError);

class ApiErrorCodes {
  static const int EXCEPTION = -5;
  static const int UNAUTHORIZED = 4;

  static const int NOT_FOUND = 2;

  static const int INVALID_REQUEST = -2;

  // [Description("Server error occured, please try again.")]
  static const int ERROR = -1;

  // [Description("FAIL")]
  static const int FAIL = -4;

  static const int VALIDATION_ERROR = 1;

  static const int INSUFFICIENT_FUND = 5;
  static const int PROCESSING_ERROR = 3;

  static const int EXISTING_ACCOUNT = 6;
  static const int EXISTING_PROFILE = 7;

  // [Description("SUCCESS")]
  static const int Ok = 0;

  // Mobile Local Error Code
  static const int SESSION_TIMEOUT = -100;
}

class CBApiError {
  int errorType = 0;
  String errorDescription;
  ApiErrorModel apiErrorModel;

  CBApiError({this.errorDescription});

  CBApiError.fromDio(Object dioError) {
    apiErrorModel = ApiErrorModel();
    _handleError(dioError);
  }

  void _handleError(Object error) {
    // non-200 error goes and handled here here.
    // String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error; // as DioError;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription = "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          // errorDescription = "Received invalid status code: ${dioError.response.statusCode}";
          if (dioError.response.statusCode == 401) {
            this.errorType = ApiErrorCodes.SESSION_TIMEOUT;
            this.errorDescription = "Your session has timed out, please login again to proceed";
          } else if (dioError.response.statusCode == 400) {
            this.apiErrorModel = ApiErrorModel.fromJson(dioError.response.data);
            this.errorDescription = this.apiErrorModel.error.userMessage;
          } else {
            this.errorDescription = "Oops! we could'nt make connections, please try again";
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    // return errorDescription;
  }
}
