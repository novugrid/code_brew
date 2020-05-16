import 'package:code_brew/src/network/ApiError.dart';
import 'package:code_brew/src/network/CBRequestInterceptor.dart';
import 'package:dio/dio.dart';

enum ApiCallStates {
  IDLE,
  LOADING,
  SUCCESS,
  ERROR
}

class NetworkUtil {
  Dio _getDioInstance() {
    var dio = Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ));
    dio.interceptors.add(CBRequestInterceptor());
    return dio;
  }

  Future<Response> connectApi(String url, RequestMethod method,
      {Map<String, dynamic> data, Map<String, dynamic> queryParams}) async {
    Response response;
    try {
      switch (method) {
        case RequestMethod.get:
          response =
          await _getDioInstance().get(url, queryParameters: queryParams);
          break;
        case RequestMethod.post:
          response = await _getDioInstance()
              .post(url, data: data, queryParameters: queryParams);
          break;
        case RequestMethod.put:
          response = await _getDioInstance()
              .put(url, data: data, queryParameters: queryParams);
          break;
        case RequestMethod.delete:
          response =
          await _getDioInstance().delete(url, queryParameters: queryParams);
          break;
      }
      return response;
      
    } on DioError catch (e, stackTace) {
      print("see error here");
      print(e);
      print(stackTace);
      
      return Future.error(ApiError.fromDio(e));
    }

    
  }
}

enum RequestMethod { get, post, put, delete }
