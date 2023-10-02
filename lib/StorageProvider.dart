import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider {
  ///Get user token
  static Future<String?> getUserToken() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("token");
  }

  ///Set User token
  static Future<void> setUserToken(String value) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("token", value);
  }

  ///Remose User token
  static Future<void> removeUserToken() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove("token");
  }
}
