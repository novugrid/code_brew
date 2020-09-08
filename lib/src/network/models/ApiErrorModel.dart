
class ApiErrorModel {

  int code;
  Error error;
  String message;
  bool success;

  ApiErrorModel({
    this.code,
    this.error,
    this.message,
    this.success,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
    code: json["code"],
    error: json["error"] != null ? Error.fromJson(json["error"]) : null,
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "error": error.toJson(),
    "message": message,
    "success": success,
  };

}


class Error {
  String devMessage;
  String possibleSolution;
  String exceptionError;
  List<dynamic> validationError;
  String userMessage;
  int errorCode;
  int statusCode;

  Error({
    this.devMessage,
    this.possibleSolution,
    this.exceptionError,
    this.validationError,
    this.userMessage,
    this.errorCode,
    this.statusCode,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    devMessage: json["devMessage"],
    possibleSolution: json["possibleSolution"],
    exceptionError: json["exceptionError"],
    validationError: List<dynamic>.from(json["validationError"].map((x) => x)),
    userMessage: json["userMessage"],
    errorCode: json["errorCode"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "devMessage": devMessage,
    "possibleSolution": possibleSolution,
    "exceptionError": exceptionError,
    "validationError": List<dynamic>.from(validationError.map((x) => x)),
    "userMessage": userMessage,
    "errorCode": errorCode,
    "statusCode": statusCode,
  };
}
