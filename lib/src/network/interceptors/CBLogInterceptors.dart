import 'dart:convert';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor{

  int _maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options) {
    print("--> ${options.method} ${options.path}");
//    print("BaseUrl -> ${options.baseUrl}");
    print("Uri -> ${options.uri}");
    print("Content type: ${options.contentType}");
    print("Headers: ${options.headers}");
    print("Body Params: ${json.encode(options.data)}");

    print("--> OUT HTTP");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print("<--- ${response.statusCode} ${response.request.method} ${response.request.path}");
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

    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("<------ ON ERROR -------->");
    print(err.error);
    print(err.message);
    if (err.response != null) {
      print(err.response.data);
    }
    print("<------ END ERROR -------->");
    return super.onError(err);
  }

}