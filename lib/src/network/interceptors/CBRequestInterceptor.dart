import 'package:code_brew/src/database/CBSessionManager.dart';
import 'package:dio/dio.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 31/03/2020
class CBRequestInterceptor extends Interceptor {
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("Cleaning up");
    if (CBSessionManager().authToken.isNotEmpty) {
      options.headers.addAll({
        "Authorization": "Bearer " + CBSessionManager().authToken,
      });
    }
    return super.onRequest(options, handler);
  }
}
