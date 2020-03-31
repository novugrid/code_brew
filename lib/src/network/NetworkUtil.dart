import 'package:dio/dio.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 31/03/2020
class NetworkUtil {
  Dio getDioInstance() {
    return Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ));
  }

  Future<Response> connectApi(String url, RequestMethod method,
      {Map<String, dynamic> data, Map<String, dynamic> queryParams}) async {
    Response response;
    try {
      switch (method) {
        case RequestMethod.get:
          response =
              await getDioInstance().get(url, queryParameters: queryParams);
          break;
        case RequestMethod.post:
          response = await getDioInstance()
              .post(url, data: data, queryParameters: queryParams);
          break;
        case RequestMethod.put:
          response = await getDioInstance()
              .put(url, data: data, queryParameters: queryParams);
          break;
        case RequestMethod.delete:
          response =
              await getDioInstance().delete(url, queryParameters: queryParams);
          break;
      }
    } on DioError catch (e) {
      response = e.response;
    }

    return response;
  }
}

enum RequestMethod { get, post, put, delete }
