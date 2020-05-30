import 'package:shared_preferences/shared_preferences.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 31/03/2020
class CBSessionManager {

  static const String KEY_AUTH_TOKEN = 'auth_token';

  static CBSessionManager _instance = CBSessionManager._internal();
  static CBSessionManager get instance => _instance;

  SharedPreferences sharedPreferences;

  // name private constructior
  CBSessionManager._internal();

  factory CBSessionManager() {
    return _instance;
  }

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value();
  }


  String get authToken =>
      sharedPreferences.getString(KEY_AUTH_TOKEN) ?? "";

  set authToken(String authToken) =>
      sharedPreferences.setString(KEY_AUTH_TOKEN, authToken);

}
