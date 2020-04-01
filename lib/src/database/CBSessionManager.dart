import 'package:shared_preferences/shared_preferences.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 31/03/2020
class CBSessionManager {
  static SharedPreferences sharedPreferences;

  static Future<Null> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String KEY_AUTH_TOKEN = 'auth_token';

  static String get authToken =>
      sharedPreferences.getString(KEY_AUTH_TOKEN) ?? '';

  static set authToken(String authToken) =>
      sharedPreferences.setString(KEY_AUTH_TOKEN, authToken);
}
