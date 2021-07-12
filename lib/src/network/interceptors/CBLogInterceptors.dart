import 'dart:convert';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("--> ${options.method} ${options.path}");
//    print("BaseUrl -> ${options.baseUrl}");
    print("Uri -> ${options.uri}");
    print("Content type: ${options.contentType}");
    print("Headers: ${options.headers}");
    print("Body Params: ${json.encode(options.data)}");

    print("--> OUT HTTP");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ${response.statusCode} ${response.requestOptions.uri} (${response.requestOptions.method})");
    // String responseAsString = response.data.toString();

    print(json.encode(response.data));

    /*if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
      (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(responseAsString.substring(
            i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      print(response.data);
    }*/
    print("<--- END INCOMING HTTP");

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("<------ ON ERROR -------->");
    print(err.error);
    print(err.message);
    if (err.response != null) {
      print(err.response.data);
    }
    print("<------ END ERROR -------->");
    return super.onError(err, handler);
  }
}
