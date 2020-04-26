import 'dart:async';

import 'package:code_brew/src/database/CBSessionManager.dart';
import 'package:dio/dio.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 31/03/2020
class CBRequestInterceptor extends Interceptor {

  Future<FutureOr> onRequest(RequestOptions options) async {
    if (CBSessionManager.authToken.isNotEmpty) {
      options.headers.addAll({
        "Authorization": "Bearer " + CBSessionManager.authToken,
      });
    }
    return options;
  }
  
}
